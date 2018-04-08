require 'json'
require "test/unit"

require_relative "main.rb"
 
class TestUsersConverter < Test::Unit::TestCase
    def test_get_users_successful
        users_file = File.read('./users.json')
        users_hash = JSON.parse(users_file)
        assert_equal(users_hash, get_json_objetcs('./users.json') )
    end

    def test_push_property
        base_array = [1]
        property = 2
        assert_equal([1, 2], push_property(base_array, property))
    end

    def test_push_array
        base_array = [1]
        property = ["a", "b"]
        assert_equal([1, "a,b"], push_array(base_array, property))
    end

    def test_is_object
        assert_equal(false, is_object?(1))
        assert_equal(false, is_object?('abc'))
        assert_equal(false, is_object?([1, 2]))
        assert_equal(true, is_object?({'a' => 'b'}))
    end

    def test_get_properties
        object = {
            'a' => 'value a',
            'b' => {
                'b1' => {
                    'b12' => 'value b12'
                },
                'b2' => {
                    'b22' => 'value b22'
                }
            }
        }
        assert_equal(['a', 'b.b1.b12', 'b.b2.b22'], get_properties(object))
    end

    def test_get_values
        object = {
            'a' => 'value a',
            'b' => {
                'b1' => {
                    'b12' => 'value b12'
                },
                'b2' => {
                    'b22' => 'value b22'
                }
            }
        }
        assert_equal(['value a', 'value b12', 'value b22'], get_values(object))
    end
end