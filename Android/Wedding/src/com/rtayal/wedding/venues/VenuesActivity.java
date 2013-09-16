package com.rtayal.wedding.venues;

import java.util.ArrayList;
import java.util.HashMap;

import android.annotation.SuppressLint;
import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.MenuItem;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.GoogleMap.OnInfoWindowClickListener;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.rtayal.wedding.Constants;
import com.rtayal.wedding.PRPlistDownloader;
import com.rtayal.wedding.PRPlistDownloader.DataDownloadListener;
import com.rtayal.wedding.R;

@SuppressLint("DefaultLocale")
public class VenuesActivity extends Activity implements DataDownloadListener,
		OnInfoWindowClickListener {

	GoogleMap mapView;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_venues);

		mapView = ((MapFragment) getFragmentManager()
				.findFragmentById(R.id.map)).getMap();

		mapView.setOnInfoWindowClickListener(this);

		PRPlistDownloader downloader = new PRPlistDownloader();
		downloader.setDataDownloadListener(this);
		downloader.execute(Constants.PRDropboxVenuesURL);

		ActionBar actionBar = getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		if (item.getItemId() == android.R.id.home) {
			finish();
			return true;
		}
		return super.onOptionsItemSelected(item);
	}

	@Override
	public void dataDownloadedSuccessfully(
			ArrayList<HashMap<String, Object>> data) {
		LatLng latLng = new LatLng(22.761062, 75.952130);
		for (HashMap<String, Object> hashMap : data) {

			latLng = new LatLng(
					Double.valueOf((String) hashMap.get("Latitude")),
					Double.valueOf((String) hashMap.get("Longitude")));
			mapView.addMarker(new MarkerOptions().position(latLng).title(
					(String) hashMap.get("Title")));
		}

		mapView.moveCamera(CameraUpdateFactory.newLatLngZoom(latLng, 11.0f));
	}

	@Override
	public void dataDownloadFailed() {
		// TODO Auto-generated method stub

	}

	@Override
	public void onInfoWindowClick(Marker marker) {
		// String uri = String.format("geo:%f,%f?q=%s",
		// marker.getPosition().latitude, marker.getPosition().longitude,
		// marker.getTitle());
		String uri = String.format("geo:%f,%f?q=%f,%f(%s)",
				marker.getPosition().latitude, marker.getPosition().longitude,
				marker.getPosition().latitude, marker.getPosition().longitude,
				marker.getTitle());
		Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(uri));
		startActivity(intent);
	}
}
