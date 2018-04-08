require 'json'


def get_users(file_path)
    begin
        users_file = File.read(file_path)
        users_hash = JSON.parse(users_file)
        print "Users imported successfully\n"
        return users_hash
    rescue JSON::ParserError
        print "Error when parsing the users file\n"
    rescue Exception
        print "Error when reading from the file path given\n"
    end
end



users = get_users('./users.json')