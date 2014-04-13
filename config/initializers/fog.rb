CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => Rails.configuration.s3_access_key_id,
    :aws_secret_access_key  => Rails.configuration.s3_secret_access_key,
  }
end