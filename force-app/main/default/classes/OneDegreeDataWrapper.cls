public class OneDegreeDataWrapper {

	public class Access_instructions {
		public Integer id {get;set;} 
		public String access_value {get;set;} 
		public String access_type {get;set;} 
		public String instructions {get;set;} 
		public Boolean enable_direct_access {get;set;} 
		public List<Attachments> locations {get;set;} 
		public List<Attachments> emails {get;set;} 

		public Access_instructions(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'access_value') {
							access_value = parser.getText();
						} else if (text == 'access_type') {
							access_type = parser.getText();
						} else if (text == 'instructions') {
							instructions = parser.getText();
						} else if (text == 'enable_direct_access') {
							enable_direct_access = parser.getBooleanValue();
						} else if (text == 'locations') {
							locations = arrayOfAttachments(parser);
						} else if (text == 'emails') {
							emails = arrayOfAttachments(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Access_instructions consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Organization {
		public Integer id {get;set;} 
		public String name {get;set;} 
		public String slug {get;set;} 
		public Integer opportunity_count {get;set;} 
		public String resource_type {get;set;} 

		public Organization(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'slug') {
							slug = parser.getText();
						} else if (text == 'opportunity_count') {
							opportunity_count = parser.getIntegerValue();
						} else if (text == 'resource_type') {
							resource_type = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Organization consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Phones {
		public Integer id {get;set;} 
		public String digits {get;set;} 
		public String phone_type {get;set;} 
		public Boolean is_primary {get;set;} 

		public Phones(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'digits') {
							digits = parser.getText();
						} else if (text == 'phone_type') {
							phone_type = parser.getText();
						} else if (text == 'is_primary') {
							is_primary = parser.getBooleanValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Phones consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Paging {
		public Integer total_count {get;set;} 
		public Integer per_page {get;set;} 
		public Integer current_page {get;set;} 
		public Integer total_pages {get;set;} 
		public Object previous_page {get;set;} 
		public String next_page {get;set;} 
		public String first_page {get;set;} 
		public String last_page {get;set;} 

		public Paging(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'total_count') {
							total_count = parser.getIntegerValue();
						} else if (text == 'per_page') {
							per_page = parser.getIntegerValue();
						} else if (text == 'current_page') {
							current_page = parser.getIntegerValue();
						} else if (text == 'total_pages') {
							total_pages = parser.getIntegerValue();
						} else if (text == 'previous_page') {
							previous_page = parser.readValueAs(Object.class);
						} else if (text == 'next_page') {
							next_page = parser.getText();
						} else if (text == 'first_page') {
							first_page = parser.getText();
						} else if (text == 'last_page') {
							last_page = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Paging consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Schedule {
		public String monday_start {get;set;} 
		public String monday_end {get;set;} 
		public String tuesday_start {get;set;} 
		public String tuesday_end {get;set;} 
		public String wednesday_start {get;set;} 
		public String wednesday_end {get;set;} 
		public String thursday_start {get;set;} 
		public String thursday_end {get;set;} 
		public String friday_start {get;set;} 
		public String friday_end {get;set;} 
		public String saturday_start {get;set;} 
		public String saturday_end {get;set;} 
		public String sunday_start {get;set;} 
		public String sunday_end {get;set;} 
		public String notes {get;set;} 

		public Schedule(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'monday_start') {
							monday_start = parser.getText();
						} else if (text == 'monday_end') {
							monday_end = parser.getText();
						} else if (text == 'tuesday_start') {
							tuesday_start = parser.getText();
						} else if (text == 'tuesday_end') {
							tuesday_end = parser.getText();
						} else if (text == 'wednesday_start') {
							wednesday_start = parser.getText();
						} else if (text == 'wednesday_end') {
							wednesday_end = parser.getText();
						} else if (text == 'thursday_start') {
							thursday_start = parser.getText();
						} else if (text == 'thursday_end') {
							thursday_end = parser.getText();
						} else if (text == 'friday_start') {
							friday_start = parser.getText();
						} else if (text == 'friday_end') {
							friday_end = parser.getText();
						} else if (text == 'saturday_start') {
							saturday_start = parser.getText();
						} else if (text == 'saturday_end') {
							saturday_end = parser.getText();
						} else if (text == 'sunday_start') {
							sunday_start = parser.getText();
						} else if (text == 'sunday_end') {
							sunday_end = parser.getText();
						} else if (text == 'notes') {
							notes = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Schedule consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Locations {
		public Integer id {get;set;} 
		public String name {get;set;} 
		public String address {get;set;} 
		public String unit {get;set;} 
		public String city {get;set;} 
		public String state {get;set;} 
		public String zip_code {get;set;} 
		public Double lat {get;set;} 
		public Double long_Z {get;set;} // in json: long
		public Boolean is_primary {get;set;} 
		public Boolean show_on_organization {get;set;} 
		public List<Phones> phones {get;set;} 
		public Schedule schedule {get;set;} 

		public Locations(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'address') {
							address = parser.getText();
						} else if (text == 'unit') {
							unit = parser.getText();
						} else if (text == 'city') {
							city = parser.getText();
						} else if (text == 'state') {
							state = parser.getText();
						} else if (text == 'zip_code') {
							zip_code = parser.getText();
						} else if (text == 'lat') {
							lat = parser.getDoubleValue();
						} else if (text == 'long') {
							long_Z = parser.getDoubleValue();
						} else if (text == 'is_primary') {
							is_primary = parser.getBooleanValue();
						} else if (text == 'show_on_organization') {
							show_on_organization = parser.getBooleanValue();
						} else if (text == 'phones') {
							phones = arrayOfPhones(parser);
						} else if (text == 'schedule') {
							schedule = new Schedule(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Locations consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Opportunities {
		public Integer id {get;set;} 
		public String title {get;set;} 
		public String description {get;set;} 
		public String slug {get;set;} 
		public List<String> all_slugs {get;set;} 
		public Boolean is_appointment {get;set;} 
		public Object available_on {get;set;} 
		public Object expires_on {get;set;} 
		public Object region {get;set;} 
		public Organization organization {get;set;} 
		public String resource_type {get;set;} 
		public List<String> tags {get;set;} 
		public List<String> categories {get;set;} 
		public List<String> areas {get;set;} 
		public Schedule schedule {get;set;} 
		public Properties properties {get;set;} 
		public List<Locations> locations {get;set;} 
		public List<Phones> phones {get;set;} 
		public List<Emails> emails {get;set;} 
		public List<Attachments> attachments {get;set;} 
		public List<Attachments> images {get;set;} 
		public List<Access_instructions> access_instructions {get;set;} 
		public Integer rating {get;set;} 
		public Boolean has_pending_submission {get;set;} 
		public String last_verified_at {get;set;} 
		public String updated_at {get;set;} 

		public Opportunities(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'title') {
							title = parser.getText();
						} else if (text == 'description') {
							description = parser.getText();
						} else if (text == 'slug') {
							slug = parser.getText();
						} else if (text == 'all_slugs') {
							all_slugs = arrayOfString(parser);
						} else if (text == 'is_appointment') {
							is_appointment = parser.getBooleanValue();
						} else if (text == 'available_on') {
							available_on = parser.readValueAs(Object.class);
						} else if (text == 'expires_on') {
							expires_on = parser.readValueAs(Object.class);
						} else if (text == 'region') {
							region = parser.readValueAs(Object.class);
						} else if (text == 'organization') {
							organization = new Organization(parser);
						} else if (text == 'resource_type') {
							resource_type = parser.getText();
						} else if (text == 'tags') {
							tags = arrayOfString(parser);
						} else if (text == 'categories') {
							categories = arrayOfString(parser);
						} else if (text == 'areas') {
							areas = arrayOfString(parser);
						} else if (text == 'schedule') {
							schedule = new Schedule(parser);
						} else if (text == 'properties') {
							properties = new Properties(parser);
						} else if (text == 'locations') {
							locations = arrayOfLocations(parser);
						} else if (text == 'phones') {
							phones = arrayOfPhones(parser);
						} else if (text == 'emails') {
							emails = arrayOfEmails(parser);
						} else if (text == 'attachments') {
							attachments = arrayOfAttachments(parser);
						} else if (text == 'images') {
							images = arrayOfAttachments(parser);
						} else if (text == 'access_instructions') {
							access_instructions = arrayOfAccess_instructions(parser);
						} else if (text == 'rating') {
							rating = parser.getIntegerValue();
						} else if (text == 'has_pending_submission') {
							has_pending_submission = parser.getBooleanValue();
						} else if (text == 'last_verified_at') {
							last_verified_at = parser.getText();
						} else if (text == 'updated_at') {
							updated_at = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Opportunities consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public Paging paging {get;set;} 
	public List<Opportunities> opportunities {get;set;} 

	public OneDegreeDataWrapper(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'paging') {
						paging = new Paging(parser);
					} else if (text == 'opportunities') {
						opportunities = arrayOfOpportunities(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'OneDegreeDataWrapper consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Emails {
		public Integer id {get;set;} 
		public String email {get;set;} 
		public String title {get;set;} 
		public String first_name {get;set;} 
		public String last_name {get;set;} 
		public Boolean is_primary {get;set;} 
		public Boolean show_on_organization {get;set;} 

		public Emails(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'email') {
							email = parser.getText();
						} else if (text == 'title') {
							title = parser.getText();
						} else if (text == 'first_name') {
							first_name = parser.getText();
						} else if (text == 'last_name') {
							last_name = parser.getText();
						} else if (text == 'is_primary') {
							is_primary = parser.getBooleanValue();
						} else if (text == 'show_on_organization') {
							show_on_organization = parser.getBooleanValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Emails consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Properties {
		public String community_seniors {get;set;} // in json: community-seniors
		public String cost_fees {get;set;} // in json: cost-fees
		public String ada_accessible_notes {get;set;} // in json: ada-accessible-notes
		public String action_signup_url {get;set;} // in json: action-signup-url
		public String community_disabled {get;set;} // in json: community-disabled
		public String service_county_california_san_francisco {get;set;} // in json: service-county-california-san-francisco
		public String ada_accessible {get;set;} // in json: ada-accessible

		public Properties(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'community-seniors') {
							community_seniors = parser.getText();
						} else if (text == 'cost-fees') {
							cost_fees = parser.getText();
						} else if (text == 'ada-accessible-notes') {
							ada_accessible_notes = parser.getText();
						} else if (text == 'action-signup-url') {
							action_signup_url = parser.getText();
						} else if (text == 'community-disabled') {
							community_disabled = parser.getText();
						} else if (text == 'service-county-california-san-francisco') {
							service_county_california_san_francisco = parser.getText();
						} else if (text == 'ada-accessible') {
							ada_accessible = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Properties consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Schedule_Z {
		public String monday_start {get;set;} 
		public String monday_end {get;set;} 
		public String tuesday_start {get;set;} 
		public String tuesday_end {get;set;} 
		public String wednesday_start {get;set;} 
		public String wednesday_end {get;set;} 
		public String thursday_start {get;set;} 
		public String thursday_end {get;set;} 
		public String friday_start {get;set;} 
		public String friday_end {get;set;} 
		public String notes {get;set;} 

		public Schedule_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'monday_start') {
							monday_start = parser.getText();
						} else if (text == 'monday_end') {
							monday_end = parser.getText();
						} else if (text == 'tuesday_start') {
							tuesday_start = parser.getText();
						} else if (text == 'tuesday_end') {
							tuesday_end = parser.getText();
						} else if (text == 'wednesday_start') {
							wednesday_start = parser.getText();
						} else if (text == 'wednesday_end') {
							wednesday_end = parser.getText();
						} else if (text == 'thursday_start') {
							thursday_start = parser.getText();
						} else if (text == 'thursday_end') {
							thursday_end = parser.getText();
						} else if (text == 'friday_start') {
							friday_start = parser.getText();
						} else if (text == 'friday_end') {
							friday_end = parser.getText();
						} else if (text == 'notes') {
							notes = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Schedule_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Attachments {

		public Attachments(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						{
							System.debug(LoggingLevel.WARN, 'Attachments consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static OneDegreeDataWrapper parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new OneDegreeDataWrapper(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	

    private static List<Attachments> arrayOfAttachments(System.JSONParser p) {
        List<Attachments> res = new List<Attachments>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Attachments(p));
        }
        return res;
    }





    private static List<Phones> arrayOfPhones(System.JSONParser p) {
        List<Phones> res = new List<Phones>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Phones(p));
        }
        return res;
    }


    private static List<Emails> arrayOfEmails(System.JSONParser p) {
        List<Emails> res = new List<Emails>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Emails(p));
        }
        return res;
    }



    private static List<Opportunities> arrayOfOpportunities(System.JSONParser p) {
        List<Opportunities> res = new List<Opportunities>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Opportunities(p));
        }
        return res;
    }



    private static List<Locations> arrayOfLocations(System.JSONParser p) {
        List<Locations> res = new List<Locations>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Locations(p));
        }
        return res;
    }








    private static List<String> arrayOfString(System.JSONParser p) {
        List<String> res = new List<String>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(p.getText());
        }
        return res;
    }






    private static List<Access_instructions> arrayOfAccess_instructions(System.JSONParser p) {
        List<Access_instructions> res = new List<Access_instructions>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Access_instructions(p));
        }
        return res;
    }




}