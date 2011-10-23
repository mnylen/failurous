module AttributesSpecHelper
  def valid_fail_data 
    {
      title:    "FailError: Epic Fail",
      location: "fails#index",

      sections: [
        { title:  "Summary",
          fields: [
            { name:    "Error type",
              value:   "FailError",
              type:    "string",
              hidden:  false,
              combine: true
            },
            { name:    "Error message",
              value:   "Epic fail",
              type:    "string",
              hidden:  false,
              combine: false
            },
            { name:    "Top line in stack trace",
              value:   "somewhere/in/the/app.rb:30",
              type:    "string",
              hidden:  true,
              combine: true
            }
          ]
        },
        { title:  "User session",
          fields: [
            { name:    "Username",
              value:   "quentin",
              type:    "string"
            }
          ]
        }
      ]
    }
  end
end
