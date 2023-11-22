const core = require('./.action/core')
const exec = require('./.action/exec')

const version = '1.0.3'

core.setCommandEcho(true)

async function run() {
    try {
        const package = 'lukas-ruzicka/testflight-feedback' + '@' + version
        
        // Make sure `Mint` is installed
        if (await isInstalled('mint')) {
            core.info('Mint is already installed.')
        } else {
            core.info('Installing mint')
            await exec.exec('brew', ['install', 'mint'])
        }
        
        // Make sure `testflight-feedback` package is installed
        if (await isInstalled('testflight-feedback')) {
            core.info('testflight-feedback is already installed')
        } else {
            core.info('Installing testflight-feedback')
            await exec.exec('mint', ['install', package])
        }
        
        let shouldClearScreenshotsOnly = core.getInput('clearScreenshotsOnly', { required: false })
        if (!!shouldClearScreenshotsOnly) {
            // Run `testflight-feedback clear`
            core.info('Clearing screenshots...')
            await exec.exec('mint', ['run', package, 'clear'])
        } else {
            // Run `testflight-feedback fetch`
            core.info('Fetching TestFlight feedback...')
            await exec.exec('mint', ['run', package, 'fetch'])
        }
    } catch (error) {
        core.setFailed(error)
    }
}

async function isInstalled(command) {
    return await exec.exec('which', [command], { silent: true, failOnStdErr: false, ignoreReturnCode: true }) == 0
}

run()
