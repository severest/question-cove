ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  setup do
      $test_current_user = users(:sean)
    end
  end


  module SMRT
    module CED
      class Service
        @@users = {
          :gavin => ActiveSupport::JSON.decode('{"phone":"","ced_mpt":true,"tId":"t895553","work_street":"3777 Kingsway","sapreleasecode":"03","roomnumber":"T1-11","mgr_province":"AB","mgr_emnumber":"867527","racfid":"","busunit":20,"ced_ext":false,"work_province":"BC","nt_userid":"t895553","fax":"","contractor":"","cell":"","crisid":"","ced_poco":"000702030605","emnumber":"895553","positioncode":"52003331","email":"gavin.mogan@telus.com","ced_level":6,"work_phone":"6046953254","work_city":"Burnaby","buildingid":"BNBYBCHQ","ced_evporgunit":"51024941","mgr_name":"Brandi Shew","is_vacant":false,"work_buildingname":"TELUS, Brian Canfield Ctr","ced_empcount":0,"lastname":"Mogan","costcentre":"0000025772","id":"t895553","positiontitle":"Developer Analyst III","orgunittitle":"TELUS TV","sap_userid":"t895553","companydesc":"TELUS Communic. (BC) Inc.","homephone":"","pager":"","orgunitcode":"52381497","work_postalcode":"V5H 3Z7","firstname":"Gavin","companycode":"510B","mgr_emnumber_chain":"867527","work_country":"Canada","preferredname":"Gavin"}'),
          :system => ActiveSupport::JSON.decode('{"phone":"","ced_mpt":true,"tId":"system","work_street":"3777 Kingsway","sapreleasecode":"03","roomnumber":"T1-11","mgr_province":"AB","mgr_emnumber":"867527","racfid":"","busunit":20,"ced_ext":false,"work_province":"BC","nt_userid":"t895553","fax":"","contractor":"","cell":"","crisid":"","ced_poco":"000702030605","emnumber":"1","positioncode":"52003331","email":"dlETI@telus.com","ced_level":6,"work_phone":"6046953254","work_city":"Burnaby","buildingid":"BNBYBCHQ","ced_evporgunit":"51024941","mgr_name":"Brandi Shew","is_vacant":false,"work_buildingname":"TELUS, Brian Canfield Ctr","ced_empcount":0,"lastname":"Mogan","costcentre":"0000025772","id":"t895553","positiontitle":"Developer Analyst III","orgunittitle":"TELUS TV","sap_userid":"t895553","companydesc":"TELUS Communic. (BC) Inc.","homephone":"","pager":"","orgunitcode":"52381497","work_postalcode":"V5H 3Z7","firstname":"Gavin","companycode":"510B","mgr_emnumber_chain":"867527","work_country":"Canada","preferredname":"System"}'),
          :nonadmin => ActiveSupport::JSON.decode('{"phone":"","ced_mpt":true,"tId":"nonadmin","work_street":"3777 Kingsway","sapreleasecode":"03","roomnumber":"T1-11","mgr_province":"AB","mgr_emnumber":"867527","racfid":"","busunit":20,"ced_ext":false,"work_province":"BC","nt_userid":"t895553","fax":"","contractor":"","cell":"","crisid":"","ced_poco":"000702030605","emnumber":"-2","positioncode":"52003331","email":"gavin.mogan@telus.com","ced_level":6,"work_phone":"6046953254","work_city":"Burnaby","buildingid":"BNBYBCHQ","ced_evporgunit":"51024941","mgr_name":"Brandi Shew","is_vacant":false,"work_buildingname":"TELUS, Brian Canfield Ctr","ced_empcount":0,"lastname":"Mogan","costcentre":"0000025772","id":"t895553","positiontitle":"Developer Analyst III","orgunittitle":"TELUS TV","sap_userid":"t895553","companydesc":"TELUS Communic. (BC) Inc.","homephone":"","pager":"","orgunitcode":"52381497","work_postalcode":"V5H 3Z7","firstname":"Gavin","companycode":"510B","mgr_emnumber_chain":"867527","work_country":"Canada","preferredname":"NonAdmin"}'),
          :noemail => ActiveSupport::JSON.decode('{"phone":"","ced_mpt":true,"tId":"noemail","work_street":"3777 Kingsway","sapreleasecode":"03","roomnumber":"T1-11","mgr_province":"AB","mgr_emnumber":"867527","racfid":"","busunit":20,"ced_ext":false,"work_province":"BC","nt_userid":"t895553","fax":"","contractor":"","cell":"","crisid":"","ced_poco":"000702030605","emnumber":"-3","positioncode":"52003331","email":"","ced_level":6,"work_phone":"6046953254","work_city":"Burnaby","buildingid":"BNBYBCHQ","ced_evporgunit":"51024941","mgr_name":"Brandi Shew","is_vacant":false,"work_buildingname":"TELUS, Brian Canfield Ctr","ced_empcount":0,"lastname":"Email","costcentre":"0000025772","id":"t895553","positiontitle":"Developer Analyst III","orgunittitle":"TELUS TV","sap_userid":"t895553","companydesc":"TELUS Communic. (BC) Inc.","homephone":"","pager":"","orgunitcode":"52381497","work_postalcode":"V5H 3Z7","firstname":"No","companycode":"510B","mgr_emnumber_chain":"867527","work_country":"Canada","preferredname":"No Email"}'),
          :ced_one => ActiveSupport::JSON.decode('{"phone":"","ced_mpt":true,"tId":"ced_one","work_street":"3777 Kingsway","sapreleasecode":"03","roomnumber":"T1-11","mgr_province":"AB","mgr_emnumber":"867527","racfid":"","busunit":20,"ced_ext":false,"work_province":"BC","nt_userid":"ced_one","fax":"","contractor":"","cell":"","crisid":"","ced_poco":"000702030605","emnumber":"ced_one","positioncode":"52003331","email":"","ced_level":6,"work_phone":"6046953254","work_city":"Burnaby","buildingid":"BNBYBCHQ","ced_evporgunit":"51024941","mgr_name":"Brandi Shew","is_vacant":false,"work_buildingname":"TELUS, Brian Canfield Ctr","ced_empcount":0,"lastname":"ced_one","costcentre":"0000025772","id":"ced_one","positiontitle":"Developer Analyst III","orgunittitle":"TELUS TV","sap_userid":"t895553","companydesc":"TELUS Communic. (BC) Inc.","homephone":"","pager":"","orgunitcode":"52381497","work_postalcode":"V5H 3Z7","firstname":"No","companycode":"510B","mgr_emnumber_chain":"867527","work_country":"Canada","preferredname":"No Email"}'),
          :go_legacy => ActiveSupport::JSON.decode('{"phone":"","ced_mpt":true,"tId":"go_legacy","work_street":"3777 Kingsway","sapreleasecode":"03","roomnumber":"T1-11","mgr_province":"AB","mgr_emnumber":"867527","racfid":"","busunit":20,"ced_ext":false,"work_province":"BC","nt_userid":"go_legacy","fax":"","contractor":"","cell":"","crisid":"","ced_poco":"000702030605","emnumber":"go_legacy","positioncode":"52003331","email":"","ced_level":6,"work_phone":"6046953254","work_city":"Burnaby","buildingid":"BNBYBCHQ","ced_evporgunit":"51024941","mgr_name":"Brandi Shew","is_vacant":false,"work_buildingname":"TELUS, Brian Canfield Ctr","ced_empcount":0,"lastname":"go_legacy","costcentre":"0000025772","id":"go_legacy","positiontitle":"Developer Analyst III","orgunittitle":"TELUS TV","sap_userid":"t895553","companydesc":"TELUS Communic. (BC) Inc.","homephone":"","pager":"","orgunitcode":"52381497","work_postalcode":"V5H 3Z7","firstname":"No","companycode":"510B","mgr_emnumber_chain":"867527","work_country":"Canada","preferredname":"No Email"}'),
          :tom => ActiveSupport::JSON.decode('{"phone":"","ced_mpt":true,"tId":"t867528","work_street":"3777 Kingsway","sapreleasecode":"03","roomnumber":"T1-11","mgr_province":"AB","mgr_emnumber":"867527","racfid":"","busunit":20,"ced_ext":false,"work_province":"BC","nt_userid":"t867528","fax":"","contractor":"","cell":"","crisid":"","ced_poco":"000702030605","emnumber":"867528","positioncode":"52003331","email":"thomas.choo@telus.com","ced_level":6,"work_phone":"6046953254","work_city":"Burnaby","buildingid":"BNBYBCHQ","ced_evporgunit":"51024941","mgr_name":"Brandi Shew","is_vacant":false,"work_buildingname":"TELUS, Brian Canfield Ctr","ced_empcount":0,"lastname":"Mogan","costcentre":"0000025772","id":"t867528","positiontitle":"Developer Analyst III","orgunittitle":"TELUS TV","sap_userid":"t867528","companydesc":"TELUS Communic. (BC) Inc.","homephone":"","pager":"","orgunitcode":"52381497","work_postalcode":"V5H 3Z7","firstname":"Gavin","companycode":"510B","mgr_emnumber_chain":"867527","work_country":"Canada","preferredname":"Gavin"}'),
          :mylinks_user => ActiveSupport::JSON.decode('{"phone":"","ced_mpt":true,"tId":"t867528","work_street":"3777 Kingsway","sapreleasecode":"03","roomnumber":"T1-11","mgr_province":"AB","mgr_emnumber":"867527","racfid":"","busunit":20,"ced_ext":false,"work_province":"BC","nt_userid":"t867528","fax":"","contractor":"","cell":"","crisid":"","ced_poco":"000702030605","emnumber":"867528","positioncode":"52003331","email":"thomas.choo@telus.com","ced_level":6,"work_phone":"6046953254","work_city":"Burnaby","buildingid":"BNBYBCHQ","ced_evporgunit":"51024941","mgr_name":"Brandi Shew","is_vacant":false,"work_buildingname":"TELUS, Brian Canfield Ctr","ced_empcount":0,"lastname":"Mogan","costcentre":"0000025772","id":"t867528","positiontitle":"Developer Analyst III","orgunittitle":"TELUS TV","sap_userid":"t867528","companydesc":"TELUS Communic. (BC) Inc.","homephone":"","pager":"","orgunitcode":"52381497","work_postalcode":"V5H 3Z7","firstname":"Gavin","companycode":"510B","mgr_emnumber_chain":"867527","work_country":"Canada","preferredname":"Gavin"}')
        }
        def from_id(id)
          if (id.to_i == 895553)
            return @@users[:gavin]
          elsif (id.to_i == -2)
            return @@users[:nonadmin]
          elsif (id.eql? "ced_one")
            return @@users[:ced_one]
          elsif (id.eql? "go_legacy")
            return @@users[:go_legacy]
          elsif (id.eql? "system")
            return @@users[:system]
          elsif (id.to_i == 867528)
            return @@users[:tom]
          elsif (id.to_i == 888888)
            return @@users[:mylinks_user]
          end
          raise "SMRT::CED.from_id doesn't know how to handle #{id}"
        end
        def from_email(email)
          # Empty is either misconfigured or jenkins
          if (email.eql? "")
            return [@@users[:noemail]]
          elsif (email.eql? "gavin.mogan@telus.com")
            return [@@users[:gavin]]
          elsif (email.eql? "thomas.choo@telus.com")
            return [@@users[:tom]]
          end
          raise "SMRT::CED.from_email doesn't know how to handle #{email}"
        end
        def from_name(name)
          if (name.eql?("Gavin Mogan"))
            return [@@users[:gavin]]
          end
          raise "SMRT::CED.from_name doesn't know how to handle #{name}"
        end
      end
    end
  end

  module SessionsHelper

    def current_backdoor_user
      ced_id = params[:as]
      if ced_id
        user = User.find_or_initialize_by(ced_id: ced_id)
        data = SMRT::CED.from_id(ced_id)
        user.update_from_hash(data)
        return user
      else
        return $test_current_user
      end
    end

    def is_logged_in?
      return true
    end

    def authenticate_via_smrtconnect
      return
    end
  end
