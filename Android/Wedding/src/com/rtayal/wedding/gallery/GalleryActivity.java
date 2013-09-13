package com.rtayal.wedding.gallery;

import java.util.ArrayList;
import java.util.HashMap;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;

import com.rtayal.wedding.R;

public class GalleryActivity extends Activity {

	private ArrayList<HashMap<String, Object>> streamList = new ArrayList<HashMap<String, Object>>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_gallery);

		downloadStream();
	}

	void downloadStream() {
		MyAsyncTask asyncTask = new MyAsyncTask();
		asyncTask.execute();
	}

	public class MyAsyncTask extends AsyncTask<Void, Void, Void> {

		@Override
		protected Void doInBackground(Void... params) {

			GalleryServiceCaller serviceCaller = new GalleryServiceCaller(
					GalleryActivity.this);
			String response = serviceCaller.newLogin("", "");
			return null;
		}
	}
}
