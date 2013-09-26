package com.rtayal.wedding;

import java.util.LinkedList;
import java.util.List;

import android.accounts.Account;
import android.accounts.AccountManager;
import android.app.Application;
import android.app.Notification;
import android.os.Build;

import com.commonsware.cwac.updater.ConfirmationStrategy;
import com.commonsware.cwac.updater.DownloadStrategy;
import com.commonsware.cwac.updater.InternalHttpDownloadStrategy;
import com.commonsware.cwac.updater.NotificationConfirmationStrategy;
import com.commonsware.cwac.updater.SimpleHttpDownloadStrategy;
import com.commonsware.cwac.updater.SimpleHttpVersionCheckStrategy;
import com.commonsware.cwac.updater.UpdateRequest;
import com.commonsware.cwac.updater.VersionCheckStrategy;
import com.localytics.android.LocalyticsSession;

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

		checkForAppUpdate();

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
				return "";
		}

		return "";
	}

	private void checkForAppUpdate() {
		UpdateRequest.Builder builder = new UpdateRequest.Builder(this);

		builder.setVersionCheckStrategy(buildVersionCheckStrategy())
				.setPreDownloadConfirmationStrategy(
						buildPreDownloadConfirmationStrategy())
				.setDownloadStrategy(buildDownloadStrategy())
				.setPreInstallConfirmationStrategy(
						buildPreInstallConfirmationStrategy()).execute();
	}

	VersionCheckStrategy buildVersionCheckStrategy() {
		String appUpdateRemoteJSONURL = Constants.AppUpdateRemoteJSON;
		return (new SimpleHttpVersionCheckStrategy(appUpdateRemoteJSONURL));
	}

	@SuppressWarnings("deprecation")
	ConfirmationStrategy buildPreDownloadConfirmationStrategy() {
		// return(new ImmediateConfirmationStrategy());
		Notification n = new Notification(R.drawable.download_update_icon,
				"App Update available", System.currentTimeMillis());

		n.setLatestEventInfo(this, "Wedding App Update Available",
				"Click to download the update!", null);
		n.flags |= Notification.FLAG_AUTO_CANCEL;
		n.flags |= Notification.FLAG_NO_CLEAR;

		return (new NotificationConfirmationStrategy(n));
	}

	DownloadStrategy buildDownloadStrategy() {
		if (Build.VERSION.SDK_INT >= 11) {
			return (new InternalHttpDownloadStrategy());
		}

		return (new SimpleHttpDownloadStrategy());
	}

	@SuppressWarnings("deprecation")
	ConfirmationStrategy buildPreInstallConfirmationStrategy() {
		// return(new ImmediateConfirmationStrategy());
		Notification n = new Notification(R.drawable.install,
				"Update ready to install", System.currentTimeMillis());

		n.setLatestEventInfo(this, "Update Ready to Install",
				"Click to install the update!", null);
		n.flags |= Notification.FLAG_AUTO_CANCEL;
		n.flags |= Notification.FLAG_NO_CLEAR;

		return (new NotificationConfirmationStrategy(n));
	}

}
