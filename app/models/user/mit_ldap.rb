class User::MitLdap < ActiveLdap::Base
  ldap_mapping dn_attribute: "uid", prefix: "ou=users,ou=moira" , scope: :sub
  
  #Searches mit ldap directory for users based on params
  #@param params: dictionary with parameters to search by
  #@return list of ldap entries for users without accounts in users database
  def self.query(params)
    search_filter = ""
    search_filter += "(uid=#{params["uname"]})" unless params["uname"].blank?
    search_filter += "(givenName=#{params["first"]})" unless params["first"].blank?
    search_filter += "(sn=#{params["last"]})" unless params["last"].blank?
    if search_filter.empty?
      return []
    else
      attrs = ["uid", "givenName", "sn", "mitDirStudentYear"]
      results = []
      User::MitLdap.search(filter: search_filter, attributes: attrs).each do | user |
        unless User.exists?(uname: user[1]["uid"][0])
          results << user[1]
        end
      end
      return results
    end
  end
  
  #Returns first name from ldap elements
  def first_name
    return self.givenname
  end
  
  #Returns last name from ldap elements
  def last_name
    return self.sn
  end
  
  #Returns graduation class from ldap elements
  def year
    if self.mitDirStudentYear
      Date.current.year + 4 - self.mitDirStudentYear.to_i + ((Date.current.month > 6)?1:0)
    else
      nil
    end
  end
  
  #Returns whether the current user is a student still
  def student?
    return self.eduPersonAffiliation=="student"
  end
end
