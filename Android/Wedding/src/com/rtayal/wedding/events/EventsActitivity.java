package com.rtayal.wedding.events;

import java.util.ArrayList;
import java.util.HashMap;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.TextView;

import com.foound.widget.AmazingAdapter;
import com.rtayal.wedding.Constants;
import com.rtayal.wedding.PRPlistDownloader.DataDownloadListener;
import com.rtayal.wedding.PRPlistDownloader;
import com.rtayal.wedding.R;

public class EventsActitivity extends Activity {

	private ArrayList<HashMap<String, Object>> allArray = new ArrayList<HashMap<String, Object>>();

	// UI References
	private ListView listView;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.activity_events);

		PRPlistDownloader downloader = new PRPlistDownloader();
		downloader.setDataDownloadListener(new DataDownloadListener() {

			@Override
			public void dataDownloadedSuccessfully(
					ArrayList<HashMap<String, Object>> data) {
				allArray = data;
				((MyListAdapter) listView.getAdapter()).notifyDataSetChanged();
			}

			@Override
			public void dataDownloadFailed() {

			}
		});
		downloader.execute(Constants.PRDropboxEventsScheduleURL);

		ActionBar actionBar = getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		listView = (ListView) findViewById(R.id.amazingListView);
		listView.setAdapter(new MyListAdapter());
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		if (item.getItemId() == android.R.id.home) {
			finish();
			return true;
		}
		return super.onOptionsItemSelected(item);
	}

	private class MyListAdapter extends AmazingAdapter {

		@Override
		public int getCount() {
			int res = 0;
			for (int i = 0; i < allArray.size(); i++) {
				res += allArray.get(i).size();
			}
			return res;
		}

		@SuppressWarnings("unchecked")
		@Override
		public HashMap<String, String> getItem(int position) {
			int c = 0;
			for (int i = 0; i < allArray.size(); i++) {
				if (position >= c && position < c + allArray.get(i).size()) {
					// return allArray.get(i).get(position - c);
					return ((ArrayList<HashMap<String, String>>) allArray
							.get(i).get("Events")).get(position - c);
				}
				c += allArray.get(i).size();
			}
			return null;
		}

		@Override
		public long getItemId(int position) {
			return position;
		}

		@Override
		protected void onNextPageRequested(int page) {
		}

		@Override
		protected void bindSectionHeader(View view, int position,
				boolean displaySectionHeader) {
			if (displaySectionHeader) {
				view.findViewById(R.id.eventDateTextView).setVisibility(
						View.VISIBLE);
				TextView lSectionTitle = (TextView) view
						.findViewById(R.id.eventDateTextView);
				lSectionTitle
						.setText(getSections()[getSectionForPosition(position)]);
			} else {
				view.findViewById(R.id.eventDateTextView).setVisibility(
						View.GONE);
			}
		}

		@Override
		public View getAmazingView(int position, View convertView,
				ViewGroup parent) {
			View res = convertView;
			if (res == null)
				res = getLayoutInflater().inflate(R.layout.schedule_item, null);

			TextView eventName = (TextView) res
					.findViewById(R.id.eventNameTextView);
			TextView eventLocation = (TextView) res
					.findViewById(R.id.eventLocationTextView);

			HashMap<String, String> composer = getItem(position);

			eventName.setText((CharSequence) composer.get("Event"));
			eventLocation.setText((String) composer.get("Location"));

			return res;
		}

		@Override
		public void configurePinnedHeader(View header, int position, int alpha) {
			TextView lSectionHeader = (TextView) header;
			lSectionHeader
					.setText(getSections()[getSectionForPosition(position)]);
			lSectionHeader.setBackgroundColor(alpha << 24 | (0xbbffbb));
			lSectionHeader.setTextColor(alpha << 24 | (0x000000));
		}

		@Override
		public int getPositionForSection(int section) {
			if (section < 0)
				section = 0;
			if (section >= allArray.size())
				section = allArray.size() - 1;
			int c = 0;
			for (int i = 0; i < allArray.size(); i++) {
				if (section == i) {
					return c;
				}
				c += allArray.get(i).size();
			}
			return 0;
		}

		@Override
		public int getSectionForPosition(int position) {
			int c = 0;
			for (int i = 0; i < allArray.size(); i++) {
				if (position >= c && position < c + allArray.get(i).size()) {
					return i;
				}
				c += allArray.get(i).size();
			}
			return -1;
		}

		@Override
		public String[] getSections() {
			String[] res = new String[2];

			for (int i = 0; i < allArray.size(); i++) {
				res[i] = (String) allArray.get(i).get("Date");
			}
			return res;
		}
	}
}
