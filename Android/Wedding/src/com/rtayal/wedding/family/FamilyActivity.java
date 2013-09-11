package com.rtayal.wedding.family;

import java.util.ArrayList;
import java.util.HashMap;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.widget.ListView;

import com.rtayal.wedding.Constants;
import com.rtayal.wedding.PRPlistDownloader;
import com.rtayal.wedding.PRPlistDownloader.DataDownloadListener;
import com.rtayal.wedding.R;

public class FamilyActivity extends Activity {

	private ListView listView;

	private ArrayList<HashMap<String, Object>> familyArrayList = new ArrayList<HashMap<String, Object>>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_family);

		PRPlistDownloader downloader = new PRPlistDownloader();
		downloader.setDataDownloadListener(new DataDownloadListener() {

			@Override
			public void dataDownloadedSuccessfully(
					ArrayList<HashMap<String, Object>> data) {
				familyArrayList = data;
				listView.setAdapter(new FamilyListAdapter(FamilyActivity.this,
						familyArrayList));
			}

			@Override
			public void dataDownloadFailed() {

			}
		});
		downloader.execute(Constants.PRDropboxThakurFamilyURL);

		ActionBar actionBar = getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		listView = (ListView) findViewById(R.id.listView);
	}
}
