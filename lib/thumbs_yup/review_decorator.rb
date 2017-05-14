class ReviewDecorator 
  attr_accessor :review

  def initialize(vars)
    @review = {
      "body" => vars["body"],
      "full_name" => full_name(vars),
      "title_and_business_name" =>  title_and_business_name(vars),
      "city_state_and_country" =>  city_state_and_country(vars),
    }
    @review = clean_vars(@review)
  end

  private

  def full_name(vars)
    return "Anonymous" unless vars["first_name"] || vars["middle_name"] || vars["last_name"] || vars["business_name"]

    separator1 = " " if vars["first_name"] && vars["middle_name"]
    separator2 = " " if (vars["first_name"] && vars["last_name"]) || (vars["middle_name"] && vars["last_name"])

    "#{vars["first_name"]}#{separator1}#{vars["middle_name"]}#{separator2}#{vars["last_name"]}"
  end

  def title_and_business_name(vars)
    separator = ", " if vars["title"] && vars["business_name"]
    "#{vars["title"]}#{separator}#{vars["business_name"]}"
  end

  def city_state_and_country(vars)
    separator1 = ", " if vars["city"] && vars["state"]
    separator2 = ", " if (vars["city"] && vars["country"]) || (vars["state"] && vars["country"]) 
    "#{vars["city"]}#{separator1}#{vars["state"]}#{separator2}#{vars["country"]}"
  end

  def clean_vars(vars)
    vars.each do |key, value|
      vars[key] ||= ""
      vars[key] = CGI::escapeHTML(vars[key])
    end
  end
end
