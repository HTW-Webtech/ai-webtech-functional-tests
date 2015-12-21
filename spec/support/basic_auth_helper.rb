module BasicAuthHelper
	def basic_auth(user: user, password: password)
    encoded_login = ["#{user}:#{password}"].pack("m*")
    encoded_login = encoded_login.chomp # Remove trailing newline
    page.driver.add_header 'Authorization', "Basic #{encoded_login}"
	end
end
