# TestFlight feedback management

![Platforms](https://img.shields.io/badge/platform-osx-lightgrey.svg)
![Language](https://img.shields.io/badge/language-swift-orange.svg)
[![Dependencies](https://img.shields.io/badge/dependency-fastlane-informational.svg)](https://github.com/fastlane/fastlane)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/lukas-ruzicka/testflight-feedback/blob/main/LICENSE)
[![Contribution welcomed!](https://img.shields.io/badge/contribution-welcomed-brightgreen.svg)](#contribution)

This tool is designed to ease management of user feedback received through TestFlight. The main purpose is to fetch the feedback and create a GitHub Issue for each, so it can be handled better (assigned to other people, boards, teams, etc.).

> The tool has originated from [a discussion started within the fastlane repository](https://github.com/fastlane/fastlane/discussions/17790), so the solution currently have dependency on [fastlane](https://github.com/fastlane/fastlane) as you need it to obtain cookies required to authorize the fetch request.

Currently only GitHub Issues are supported as an output - if you'd like to have any other integration, feel free to [contribute](#contribution)) 🙏🏻


## Installation

The tool is designed to be run automatically using GitHub Actions. If you want to set your repository up straightaway, you can just skip to [the following section](#github_action).

You can install the tool using [Mint](https://github.com/yonaskolb/mint):

```shell
mint install lukas-ruzicka/testflight-feedback
```

> If you haven’t used Mint before, you'd need to add the “Mint bin” path to `$PATH` (follow the instructions provided by the tool).

or you can clone the repository and build the package yourself by running:

```shell
git clone https://github.com/lukas-ruzicka/testflight-feedback
swift run testflight-feedback ...
```

## Usage

Before you use one of the commands, you need to set up few parameters.

### Parameters

> All parameters can be passed as command parameter or set as environment variable. The only exception is the authorization cookies variable that can be set as environment variable or be stored as the last value in the clipboard.

For all the subcommands, you need these two parameters:
- [GitHub personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) with the `repo` scope (env variable: `GITHUB_TOKEN`)
- path to the GitHub repository (env variable: `FEEDBACK_REPOSITORY_PATH`)

#### App Store Connect authorization cookies 🍪🍪

These are the most important cookies that authorizes you for the App Store Connect, so the feedback can be fetched. It can be obtained [using `spaceauth` method provided by `fastlane`](https://docs.fastlane.tools/getting-started/ios/authentication/).

> You need to have Apple ID with access to the app in App Store Connect.

<a name="auth_cookies">
Get the cookies by running
</a>

```shell
fastlane spaceauth -u your_appleID_email
``` 

Then choose to copy the cookies. You can then run the `fetch` or `auth` command directly (it uses the cookies from the clipboard) or set them to the `FASTLANE_SESSION` environment variable.

> Lifetime of the cookies may vary between 1 to 30 days. It can't be automated because of the 2FA needed for the Apple ID login.

### `testflight-feedback fetch`

This command fetches the feedback (60 latest items) and creates GitHub Issues out of all new ones (filtered by timestamp saved in the Issues).

There's few additional parameters that need to be passed:
- App Store App ID (env variable: `FEEDBACK_APP_ID`)
- Issuer ID of your Apple Developer account (env variable: `FEEDBACK_ISSUER_ID`) - you can find the ID in [the App Store Connect](https://appstoreconnect.apple.com/access/api) under _Users and Access / Keys_ section (mind that you need to have at least one App Store Connect API key created to see the Issuer ID) 

and one optional one, that could help you assign the newly created issues to a GitHub Board:
- ID of the column you want the issue to be added at (env variable: `FEEDBACK_BACKLOG_COLUMN_ID`)

```shell
testflight-feedback fetch \
--github-token your_github_token \
--repository-path your_repository_path \
--app-id your_apps_id \
--issuer-id your_issuer_id \
--backlog-column-id your_backlog_column_id
```

### `testflight-feedback auth`

Unfortunately, this command is not able to create the cookies (yet 👀). It only uploads [the ones created by fastlane](#auth_cookies) to the repositories secrets (needed for [the GitHub actions](#github_action)).

```shell
testflight-feedback auth \
--github-token your_github_token \
--repository-path your_repository_path
```

### `testflight-feedback clear`

The `fetch` command is uploading screenshots to the repository, so it can be referenced in the created Issues. As the count of them may grow quite significantly, this command takes care of removing all the screenshots from Issues that were closed more than 30 days ago. 

```shell
testflight-feedback clear \
--github-token your_github_token \
--repository-path your_repository_path
```

## GitHub action

<a name="github_action">
You can use the tool as a GitHub Action and automate the script executing, so it fetches the feedback regularly. There's an example of usage:
</a>

### Fetching the feedback

You need to add a `FASTLANE_SESSION` [secret to the repository](https://docs.github.com/en/actions/security-guides/encrypted-secrets) and refresh it regularly. You can use the `auth` command to upload the [authorization cookies](#auth_cookies).

```yaml
name: Fetch feedback

on:
  schedule:
    # Every hour on weekdays from 6:00 to 16:00 (UTC)
    - cron: '0 6-16 * * 1-5'
  workflow_dispatch:

jobs:

  runScript:

    permissions: write-all
    runs-on: macos-12

    steps:
    - name: Fetch feedback
      uses: lukas-ruzicka/testflight-feedback@1.0.1
      env:
        FASTLANE_SESSION: ${{ secrets.FASTLANE_SESSION }}
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        FEEDBACK_REPOSITORY_PATH: ${{ github.repository }}
        FEEDBACK_APP_ID: your_apps_id
        FEEDBACK_ISSUER_ID: your_issuer_id
        FEEDBACK_BACKLOG_COLUMN_ID: your_backlog_column_id
```

> Runs automatically every hour on weekdays from 6:00 to 16:00 (UTC)

> The backlog column ID is optional.

### Clearing screenshots from the repository

If you want, you can add this workflow to clear screenshots from old closed Issues from the repository.

```yaml
name: Clear screenshots of old closed Issues

on:
  schedule:
    # Every Monday at 6:00 (UTC)
    - cron: '0 6 * * 1'
  workflow_dispatch:

jobs:

  runScript:

    permissions: write-all
    runs-on: macos-12

    steps:
    - name: Clear screenshots
      uses: lukas-ruzicka/testflight-feedback@1.0.1
      with:
        clearScreenshotsOnly: true
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        FEEDBACK_REPOSITORY_PATH: ${{ github.repository }}
```

> Runs automatically every Monday at 6:00 (UTC)


## Output ticket

You can find the example output ticket [in the Issues of this repository](https://github.com/lukas-ruzicka/testflight-feedback/issues/1). By default it is named by the timestamp (as it's the unique identifier) and contains all information as you can find in the App Store Connect. Additionally, there's:
- link to translation if the comment is in other language than English
- link to the original App Store Connect ticket
- link to device specifications
- iOS version added as label
- build version added as milestone (in format `version (build_number)`)


## Contribution

<a name="contribution">
I'm happy to share the progress on this topic and I know there's still a lot to be improved, so feel free to propose changes as suggestions (create an Issue) or, even better, in a form of code (create a Pull Request). Thank you for the cooperation and enjoy the tool 😎.
</a>

Please follow the [Code of Conduct](https://github.com/lukas-ruzicka/testflight-feedback/blob/main/CODE_OF_CONDUCT.md).

> Thanks for contribution in the early stages to [@benrudhart](https://github.com/benrudhart) 🙏🏼


## License

This project is licensed under the terms of the MIT license. See the [LICENSE](https://github.com/lukas-ruzicka/testflight-feedback/blob/main/LICENSE) file.
