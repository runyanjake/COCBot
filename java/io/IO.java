package io;

import java.util.Iterator;
import static java.lang.Math.toIntExact;

import java.util.ArrayList;
import java.io.FileReader;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.json.simple.parser.JSONParser;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;

import io.AccountInfo;
import io.ClashInfo;

public class IO {

	public static ArrayList<AccountInfo> readAccountInfo(String filePath) {
        JSONParser jsonParser = new JSONParser();
        ArrayList<AccountInfo> res = new ArrayList<>();
        try (FileReader reader = new FileReader(filePath))
        {
            //Read JSON file
            JSONObject obj = (JSONObject)jsonParser.parse(reader);
            JSONArray accounts = (JSONArray) obj.get("accounts");
            Iterator it = accounts.iterator();
            while(it.hasNext()) {
            	JSONObject next = (JSONObject) it.next();
	            String type = (String) next.get("type");
	            JSONObject user = (JSONObject) next.get("user");
	            String firstName = (String) user.get("first_name");
	            String lastName = (String) user.get("last_name");
	            String email = (String) user.get("email");
	            String email_pw = (String) user.get("email_pw");
	            String birthday = (String) user.get("birthday");
	            JSONObject clashInfo = (JSONObject) next.get("clash_info");
	            int campSize = toIntExact(((Long) clashInfo.get("camp_size")).longValue());
	            int numBarracks = toIntExact(((Long) clashInfo.get("num_barracks")).longValue());
	            res.add(new AccountInfo(type, new User(firstName, lastName, email, email_pw, birthday), new ClashInfo(campSize, numBarracks)));
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException();
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException();
        } catch (ParseException e) {
            e.printStackTrace();
            throw new RuntimeException();
        }
		return res;
	}
}