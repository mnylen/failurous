class DemoFailGenerator
  
  POSSIBLE_TYPES = [
    NoMethodError, ActionController::RoutingError,
    TypeError, NameError, StandardError
  ]

  MESSAGES = [
    "Could not find FooBar with ID = baz",
    "No route for /kakka",
    "can't convert Hash into String",
    "Invalid JSON string"
  ]

  LOCATIONS = [
    "answer_forms_controller#show",
    "reports_controller#generror"
  ]
  
  
  def run
    10.times do
      gen
    end
  end
  
  def gen
    begin
      type = POSSIBLE_TYPES[rand(POSSIBLE_TYPES.size)]
      msg  = MESSAGES[rand(MESSAGES.size)]
      error = type.new(msg)
    
      raise error
    rescue => boom
      data = [
        [:summary, [
          [:type, boom.class.to_s, {:use_in_checksum => true}],
          [:message, boom.message, {:use_in_checksum => false}],
          [:location, LOCATIONS[rand(LOCATIONS.size)], {:use_in_checksum => false}],
          [:top_of_backtrace, boom.backtrace[0], {:use_in_checksum => false}]
        ]],
        [:info, [
          [:full_backtrace, boom.backtrace.join('\n'), {:use_in_checksum => false}],
          [:parameters, "{'hello' => 'moi'}", {:use_in_checksum => false}]
        ]]
      ]
      
      project = Project.all[rand(Project.count)]
      Fail.create_or_combine_with_similar_fail(project,
        {:title => "#{boom.class}: #{boom.message}",
         :data => data})
    end
  end
end

