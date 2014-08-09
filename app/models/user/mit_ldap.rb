class User::MitLdap < ActiveLdap::Base
  ldap_mapping dn_attribute: "uid", prefix: "ou=users,ou=moira" , scope: :sub
  
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
