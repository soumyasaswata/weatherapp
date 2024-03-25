module CustomExceptions
  class LocationNotFoundError < StandardError
    def message
      'Location not found for the given zipcode and country code'
    end
  end

  class InvalidInputError < StandardError
    def message
      'Invalid input provided'
    end
  end
end