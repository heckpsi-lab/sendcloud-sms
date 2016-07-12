require 'digest'
require 'rest-client'
require 'json'
require 'yaml'

module SendCloud
  class SMS

    def self.load!(file, environment)
      config = YAML.load_file(file)
      self.auth(config[environment.to_s]['user'], config[environment.to_s]['api_key'])
    end

    def self.auth(user, api_key)
      @user = user
      @api_key = api_key
    end

    def self.sign(template, phone, vars)
      param_str = "#{@api_key}&"
      {
          smsUser: @user,
          templateId: template,
          msgType: 0,
          phone: (phone.is_a?Array) ? phone.join(',') : phone,
          vars: vars.to_json
      }.sort {|a, b| a.to_s <=> b.to_s}.map { |item| param_str << "#{item[0]}=#{item[1]}&" }
      param_str << @api_key
      Digest::MD5.new.update(param_str)
    end

    def self.sign_voice(phone, code)
      param_str = "#{@api_key}&"
      {
          smsUser: @user,
          phone: phone,
          code: code
      }.sort {|a, b| a.to_s <=> b.to_s}.map { |item| param_str << "#{item[0]}=#{item[1]}&" }
      param_str << @api_key
      Digest::MD5.new.update(param_str)
    end

    def self.send(template, phone, vars)
      signature = sign(template, phone, vars)
      response = RestClient.post 'http://sendcloud.sohu.com/smsapi/send?',
                                 smsUser: @user,
                                 templateId: template,
                                 msgType: 0,
                                 phone: (phone.is_a?Array) ? phone.join(',') : phone,
                                 vars: vars.to_json,
                                 signature: signature
      JSON.parse(response.to_s)['statusCode']
    end

    def self.send_voice(phone, code)
      signature = sign_voice(phone, code)
      response = RestClient.post 'http://sendcloud.sohu.com/smsapi/sendVoice?',
                                 smsUser: @user,
                                 phone: phone,
                                 code: code,
                                 signature: signature
      JSON.parse(response.to_s)['statusCode']
    end
  end
end