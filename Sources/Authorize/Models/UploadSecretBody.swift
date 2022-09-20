struct UploadSecretBody: Encodable {

    let encrypted_value: String
    let key_id: String
}
