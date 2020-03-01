require './lib/my_error.rb'


class Upload

  require 'csv'

  attr_accessor :file_data



  def initialize(file_data)
    @file_data = file_data
  end


  # Step 1 : it creates array of hash from uploaded file
  # Step 2 : it creates a new csv file with different fields

  def import_data

    begin

      puts("FILENAME : #{self.file_data}")

      error_message = "Please enter a valid file path."

      raise MyError.new(error_message) if self.file_data.nil? or self.file_data == ''

      items = []

      filename = File.dirname(File.dirname(File.expand_path(__FILE__))) + '/tmp/'+ self.file_data

      puts("FILE_PATH : #{filename}")

      CSV.foreach(filename, headers: true) do |row|

        my_array = row.to_s.split(".")
        first_name = my_array[0]
        last_name = (my_array[1]).split("@")[0]
        email = row.to_h['email']

        my_hash = { 'first_name'   => first_name,
                    'last_name'    => last_name,
                    'email'        => email }

        items << my_hash

      end

      self.create_csv(items)

    rescue MyError => e
      print "\n #{e.message} \n"
    end

  end

  def create_csv(items)

    scope_id = Simundia::SCOPE_ID

    file = File.dirname(File.dirname(File.expand_path(__FILE__))) + '/tmp/result.csv'

    headers = ["first_name", "last_name", "scope_id", "email"]

    CSV.open(file, 'w', write_headers: true, headers: headers) do |writer|
      items.each do |item|
        writer << [(item['first_name']).capitalize, (item['last_name']).upcase, scope_id, (item['email']).downcase]
      end
    end

    print "\n Email file successfully uploaded.\n You can find the generated CSV file in tmp folder.\n "

  end

end