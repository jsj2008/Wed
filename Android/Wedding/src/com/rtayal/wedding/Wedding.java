package com.rtayal.wedding;

import java.util.LinkedList;
import java.util.List;

import com.localytics.android.LocalyticsSession;

import android.accounts.Account;
import android.accounts.AccountManager;
import android.app.Application;

public class Wedding extends Application {

	public Wedding() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void onCreate() {
		// TODO Auto-generated method stub
		super.onCreate();
		LocalyticsSession ls = new LocalyticsSession(getApplicationContext(),
				Constants.Localytics_App_Key);

		ls.tagEvent(getUserName());
		ls.upload();
		ls.close();
	}

	String getUserName() {
		AccountManager manager = AccountManager.get(getApplicationContext());
		Account[] accounts = manager.getAccountsByType("com.google");
		List<String> possibleEmails = new LinkedList<String>();

		for (Account account : accounts) {
			possibleEmails.add(account.name);
		}

		if (!possibleEmails.isEmpty() && possibleEmails.get(0) != null) {
			String email = possibleEmails.get(0);
			String[] parts = email.split("@");
			if (parts.length > 0 && parts[0] != null) {
				return parts[0];
			} else
				return null;
		}

		return null;
	}

}
