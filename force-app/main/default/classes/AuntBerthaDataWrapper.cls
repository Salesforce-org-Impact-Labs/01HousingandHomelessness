public class AuntBerthaDataWrapper {

    public class Friday {
    }

    public class Hours {
        public Boolean friday;
        public Boolean friday_all_day;
        public String friday_finish;
        public String friday_start;
        public Boolean monday;
        public Boolean monday_all_day;
        public String monday_finish;
        public String monday_start;
        public Boolean saturday;
        public Boolean saturday_all_day;
        public Boolean sunday;
        public Boolean sunday_all_day;
        public Boolean thursday;
        public Boolean thursday_all_day;
        public String thursday_finish;
        public String thursday_start;
        public String timezone;
        public Boolean tuesday;
        public Boolean tuesday_all_day;
        public String tuesday_finish;
        public String tuesday_start;
        public Boolean wednesday;
        public Boolean wednesday_all_day;
        public String wednesday_finish;
        public String wednesday_start;
    }

    public class Open_now_info {
        public String close_time;
        public String day_of_the_week;
        public Boolean open_all_day;
        public Boolean open_now;
        public String open_time;
    }

    public class Next_steps {
        public String action;
        public String channel;
        public String contact;
    }

    public class Central_hours_of_operation {
        public Friday friday;
        public Friday monday;
        public Friday saturday;
        public Friday sunday;
        public Friday thursday;
        public Friday tuesday;
        public Friday wednesday;
    }

    public class Offices {
        public String address1;
        public String city;
        public Double distance;
        public String fax_number;
        public Hours hours;
        public Boolean is_administrative;
        public Location location;
        public String name;
        public String notes;
        public String office_numeric_id;
        public List<String> office_type;
        public Open_now_info open_now_info;
        public String phone_number;
        public String postal;
        public String state;
        public List<String> supported_languages;
        public String url_safe_key;
    }

    public class Location {
        public Double latitude;
        public Double longitude;
    }

    public List<String> attribute_tags;
    public String availability;
    public Central_hours_of_operation central_hours_of_operation;
    public String coverage_description;
    public String description;
    public String directions;
    public String entry_date;
    public String facebook_url;
    public String free_or_reduced;
    public String google_plus_id;
    public String grain;
    public List<String> grain_location;
    public String id;
    public Boolean isOfficeAvailable;
    public String name;
    public List<Next_steps> next_steps;
    public List<Offices> offices;
    public String program_numeric_id;
    public String provider_name;
    public String provider_numeric_id;
    public Double score;
    public List<String> service_tags;
    public List<String> supported_languages;
    public String twitter_id;
    public String update_date;
    public String validation_date;
    public String video_url;
    public String website_url;
    public Double wl_score;

    
    public static AuntBerthaDataWrapper parse(String json) {
        return (AuntBerthaDataWrapper) System.JSON.deserialize(json, AuntBerthaDataWrapper.class);
    }
}