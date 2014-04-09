CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAI7VMQRM4JCORH35A',                        # required
      :aws_secret_access_key  => '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',                        # required              # optional, defaults to 'us-east-1'
    }
    config.fog_directory   = 'myflixq' # required
    config.fog_public = false
end