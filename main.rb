require 'json'
require 'csv'

def push_property(base_array, property)
    base_array << property
end

def push_array(base_array, array)
    base_array << array.join(',')
end

def is_object?(variable)
    variable.is_a?(Hash)
end

def get_properties(object, properties=[], base_key=nil)
    object.keys.each do |key|
        if is_object?(object[key])
            if base_key
                get_properties(object[key], properties, "#{base_key}.#{key}")
            else
                get_properties(object[key], properties, key)
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

def get_values(object, values=[])
    object.keys.each do |key|
        if is_object?(object[key])
            get_values(object[key], values)
        else
            if object[key].is_a?(Array)
                push_array(values, object[key])
            else
                push_property(values, object[key])
            end
        end
    end
    return values
end

def get_json_objetcs(file_path)
    begin
        json_objects_file = File.read(file_path)
        json_objects_hash = JSON.parse(json_objects_file)
        print "Objects imported successfully\n"
        return json_objects_hash
    rescue JSON::ParserError
        print "Error when parsing the JSON objects file\n"
    rescue Exception
        print "Error when reading from the file path given\n"
    end
end

def export_to_csv_file(file_name, objects)
    CSV.open(file_name, "w") do |csv|
        begin
            csv << get_properties(objects.first())
            print "All objects propoerty names have been correctly exported to the CSV file\n"
            objects.each do |object|
                csv << get_values(object)
                print "Information from object #{object['id']} have been correctly exported to the CSV file\n"
            end
        rescue Exception
            print "There has been an error while exporting the object information to the CSV file\n"
        end
    end
end


def convert_json_to_csv(input_file_path, export_file_path)
    imported_objects = get_json_objetcs(input_file_path)
    export_to_csv_file(export_file_path, imported_objects)
end

convert_json_to_csv('./users.json', './output.csv')
