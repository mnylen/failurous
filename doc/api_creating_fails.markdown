# API / Creating fails

	POST /api/fails

## Parameters

* `api_key` - Project's API KEY
* `data` - Fail data in JSON

Example `data` parameter contents:

    {
      "sections" : [
        { "name"   : "Section A",
          "fields" : [
            {
              "name"    : "Field Name",
              "value"   : "Field Value",
              "type"    : "Field Type (ignored by core)",
              "combine" : true,
              "hidden"  : false
            },
         },
         ...
      ]
    }
   
## Response

200 OK if everything went well

Something else if there was an error 
