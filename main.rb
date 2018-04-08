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

def push_simple_property(base_array, property)
    base_array << property
end

def push_array(base_array, array)
    base_array << array.join(',')
end

def is_object?(variable)
    variable.is_a?(Hash)
end

def get_properties(user, properties=[], base_key=nil)
    user.keys.each do |key|
        if is_object?(user[key])
            if base_key
                get_properties(user[key], properties, "#{base_key}.#{key}")
            else
                get_properties(user[key], properties, key)
            end
        else
            if base_key
                properties << "#{base_key}.#{key}"
            else
                properties << key
            end
        end
    end
    return properties
end

def get_values(user, values=[])
    user.keys.each do |key|
        if is_object?(user[key])
            get_values(user[key], values)
        else
            if user[key].is_a?(Array)
                push_array(values, user[key])
            else
                push_simple_property(values, user[key])
            end
        end
    end
    return values
end

users = get_users('./users.json')