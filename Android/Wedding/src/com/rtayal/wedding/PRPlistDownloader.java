package com.rtayal.wedding;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import xmlwise.Plist;
import xmlwise.XmlParseException;
import android.os.AsyncTask;
import android.util.Log;

public class PRPlistDownloader extends AsyncTask<String, Void, String> {

	DataDownloadListener dataDownloadListener;

	private ArrayList<HashMap<String, Object>> resultArray = new ArrayList<HashMap<String, Object>>();

	public static interface DataDownloadListener {
		void dataDownloadedSuccessfully(ArrayList<HashMap<String, Object>> data);

		void dataDownloadFailed();
	}

	public void setDataDownloadListener(
			DataDownloadListener dataDownloadListener) {
		this.dataDownloadListener = dataDownloadListener;
	}

	@SuppressWarnings("unchecked")
	@Override
	protected String doInBackground(String... urls) {

		BufferedReader in = null;
		String response = "";
		String str;
		try {
			URL url = new URL(urls[0]);
			in = new BufferedReader(new InputStreamReader(url.openStream()));
			while ((str = in.readLine()) != null) {
				response += str;
			}
			in.close();

			resultArray = new ArrayList<HashMap<String, Object>>();

			resultArray = (ArrayList<HashMap<String, Object>>) Plist
					.objectFromXml(response);
			Log.i("Dummy", resultArray.toString());

		} catch (IOException e) {
			e.printStackTrace();
		} catch (XmlParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	protected void onPostExecute(String result) {
		// TODO Auto-generated method stub
		super.onPostExecute(result);
		if (resultArray != null) {
			dataDownloadListener.dataDownloadedSuccessfully(resultArray);
		} else {
			dataDownloadListener.dataDownloadFailed();
		}
	}
}
