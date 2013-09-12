package com.rtayal.wedding.venues;

import android.os.Bundle;

import com.google.android.maps.MapActivity;
import com.rtayal.wedding.R;

public class VenuesActivity extends MapActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_venues);
	}

	@Override
	protected boolean isRouteDisplayed() {
		// TODO Auto-generated method stub
		return false;
	}

}
