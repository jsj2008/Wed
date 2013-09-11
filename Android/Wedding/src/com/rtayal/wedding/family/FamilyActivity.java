package com.rtayal.wedding.family;

import java.util.ArrayList;
import java.util.HashMap;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.widget.ListView;
import android.widget.TabHost;
import android.widget.TabHost.OnTabChangeListener;
import android.widget.TabHost.TabSpec;

import com.rtayal.wedding.Constants;
import com.rtayal.wedding.PRPlistDownloader;
import com.rtayal.wedding.PRPlistDownloader.DataDownloadListener;
import com.rtayal.wedding.R;

public class FamilyActivity extends Activity {

	private ListView listView;

	private ArrayList<HashMap<String, Object>> thakurFamilyArrayList = new ArrayList<HashMap<String, Object>>();
	private ArrayList<HashMap<String, Object>> tayalFamilyArrayList = new ArrayList<HashMap<String, Object>>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_family);

		ActionBar actionBar = getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		listView = (ListView) findViewById(R.id.familyListView);

		setupTabs();
	}

	void downloadFamilyList(final Boolean thakurs) {
		PRPlistDownloader downloader = new PRPlistDownloader();
		downloader.setDataDownloadListener(new DataDownloadListener() {

			@Override
			public void dataDownloadedSuccessfully(
					ArrayList<HashMap<String, Object>> data) {
				if (thakurs) {
					thakurFamilyArrayList = data;
					listView.setAdapter(new FamilyListAdapter(
							FamilyActivity.this, thakurFamilyArrayList));
				} else {
					tayalFamilyArrayList = data;
					listView.setAdapter(new FamilyListAdapter(
							FamilyActivity.this, tayalFamilyArrayList));
				}
			}

			@Override
			public void dataDownloadFailed() {

			}
		});
		if (thakurs) {
			downloader.execute(Constants.PRDropboxThakurFamilyURL);
		} else
			downloader.execute(Constants.PRDropboxTayalFamilyURL);
	}

	void setupTabs() {
		final TabHost tabHost = (TabHost) findViewById(R.id.fileTabHost);
		tabHost.setOnTabChangedListener(new OnTabChangeListener() {

			@Override
			public void onTabChanged(String tabId) {
				int i = tabHost.getCurrentTab();

				if (i == 0) {
					if (thakurFamilyArrayList.size() == 0) {
						downloadFamilyList(true);
					} else
						listView.setAdapter(new FamilyListAdapter(
								FamilyActivity.this, thakurFamilyArrayList));
				}

				if (i == 1) {
					if (tayalFamilyArrayList.size() == 0) {
						downloadFamilyList(false);
					} else
						listView.setAdapter(new FamilyListAdapter(
								FamilyActivity.this, tayalFamilyArrayList));
				}
			}
		});
		tabHost.setup();

		TabSpec spec1 = tabHost.newTabSpec("THAKUR'S");
		spec1.setContent(R.id.familyListView);
		spec1.setIndicator("THAKUR'S");

		TabSpec spec2 = tabHost.newTabSpec("TAYAL'S");
		spec2.setContent(R.id.familyListView);
		spec2.setIndicator("TAYAL'S");

		tabHost.addTab(spec1);
		tabHost.addTab(spec2);
	}
}
