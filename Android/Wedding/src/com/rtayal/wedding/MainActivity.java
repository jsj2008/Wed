package com.rtayal.wedding;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

public class MainActivity extends Activity implements OnClickListener {

	private Button eventsButton, galleryButton, venuesButton, familyButton;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		eventsButton = (Button) findViewById(R.id.buttonEvents);
		eventsButton.setOnClickListener(this);

		galleryButton = (Button) findViewById(R.id.buttonGallery);
		galleryButton.setOnClickListener(this);

		venuesButton = (Button) findViewById(R.id.buttonVenues);
		venuesButton.setOnClickListener(this);

		familyButton = (Button) findViewById(R.id.buttonFamily);
		familyButton.setOnClickListener(this);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		switch (v.getId()) {
		case R.id.buttonEvents:
			Intent eventIntent = new Intent(this, EventsActitivity.class);
			startActivity(eventIntent);
			break;
		case R.id.buttonGallery:
			Intent galleryIntent = new Intent(this, GalleryActivity.class);
			startActivity(galleryIntent);
			break;
		case R.id.buttonVenues:
			Intent venuesIntent = new Intent(this, VenuesActivity.class);
			startActivity(venuesIntent);
			break;
		case R.id.buttonFamily:
			Intent familyIntent = new Intent(this, FamilyActivity.class);
			startActivity(familyIntent);
			break;
		default:
			break;
		}
	}
}
