package com.rtayal.wedding;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import android.app.Activity;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.TextView;

import com.foound.widget.AmazingAdapter;

public class EventsActitivity extends Activity {

	private ArrayList<ArrayList<HashMap<String, String>>> allArray = new ArrayList<ArrayList<HashMap<String, String>>>();

	// UI References
	private ListView listView;

	@SuppressWarnings("unchecked")
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.activity_events);

		URL url = null;
		try {
			url = new URL(
					"https://dl.dropboxusercontent.com/u/57884865/wedding_app_files/schedule_list.plist");
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		BufferedReader in = null;
		try {
			in = new BufferedReader(new InputStreamReader(
					url.openStream()));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String all = "";
		String str;
		try {
			while ((str = in.readLine()) != null) {
				all += str;
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			in.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// ActionBar actionBar = getActionBar();
		// actionBar.setDisplayHomeAsUpEnabled(true);

		// allArray.add(freightsArray);
		// allArray.add(UPSArray);

		listView = (ListView) findViewById(R.id.amazingListView);
		listView.setAdapter(new MyListAdapter());
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// TODO Auto-generated method stub
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

		@Override
		public HashMap<String, String> getItem(int position) {
			int c = 0;
			for (int i = 0; i < allArray.size(); i++) {
				if (position >= c && position < c + allArray.get(i).size()) {
					return allArray.get(i).get(position - c);
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
//				view.findViewById(R.id.header).setVisibility(View.VISIBLE);
//				TextView lSectionTitle = (TextView) view
//						.findViewById(R.id.header);
//				lSectionTitle
//						.setText(getSections()[getSectionForPosition(position)]);
			} else {
//				view.findViewById(R.id.header).setVisibility(View.GONE);
			}
		}

		@Override
		public View getAmazingView(int position, View convertView,
				ViewGroup parent) {
			View res = convertView;
//			if (res == null)
//				res = getLayoutInflater().inflate(
//						R.layout.wm_shipping_calc_detail_item, null);

//			TextView lName = (TextView) res
//					.findViewById(R.id.shipMethodTextView);
//			TextView lYear = (TextView) res
//					.findViewById(R.id.shipPriceTextView);
//
//			HashMap<String, String> composer = getItem(position);
//			String price;
//			if (getSectionForPosition(position) == 0) {
//				lName.setText(composer.get("Carrier"));
//				price = composer.get("Net");
//			} else {
//				lName.setText(composer.get("Ship_Type_Desc"));
//				price = composer.get("Ship_Type_Price");
//			}
//
//			lYear.setText(formatPriceString(price));
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
			res[0] = "LTL";
			res[1] = "UPS";
			// for (int i = 0; i < allArray.size(); i++) {
			// res[i] = allArray.get(i);
			// }
			return res;
		}

	}
}
