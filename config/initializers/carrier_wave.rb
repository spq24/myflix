CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAJWPCMYQ4Q3OEB7QQ',                        # required
      :aws_secret_access_key  => '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',                       
    }
    config.fog_directory   = 'myflixq' # required
    config.fog_public = false
end