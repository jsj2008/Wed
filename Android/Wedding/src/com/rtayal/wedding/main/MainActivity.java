package com.rtayal.wedding.main;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;

import com.localytics.android.LocalyticsSession;
import com.rtayal.wedding.Constants;
import com.rtayal.wedding.PRTypeFace;
import com.rtayal.wedding.R;
import com.rtayal.wedding.events.EventsActitivity;
import com.rtayal.wedding.family.FamilyActivity;
import com.rtayal.wedding.gallery.GalleryActivity;
import com.rtayal.wedding.venues.VenuesActivity;

@SuppressLint({ "SimpleDateFormat", "DefaultLocale" })
public class MainActivity extends Activity implements OnClickListener {

	private Button eventsButton, galleryButton, venuesButton, familyButton;

	private TextView countDownTV;

	LocalyticsSession localyticsSession;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		localyticsSession = new LocalyticsSession(getApplicationContext(),
				Constants.Localytics_App_Key);
		localyticsSession.open();
		localyticsSession.upload();

		eventsButton = (Button) findViewById(R.id.buttonEvents);
		eventsButton.setOnClickListener(this);
		eventsButton.setTypeface(PRTypeFace.tfWithFont(this,
				PRTypeFace.PRFontHelveticaNeueLight));

		galleryButton = (Button) findViewById(R.id.buttonGallery);
		galleryButton.setOnClickListener(this);
		galleryButton.setTypeface(PRTypeFace.tfWithFont(this,
				PRTypeFace.PRFontHelveticaNeueLight));

		venuesButton = (Button) findViewById(R.id.buttonVenues);
		venuesButton.setOnClickListener(this);
		venuesButton.setTypeface(PRTypeFace.tfWithFont(this,
				PRTypeFace.PRFontHelveticaNeueLight));

		familyButton = (Button) findViewById(R.id.buttonFamily);
		familyButton.setOnClickListener(this);
		familyButton.setTypeface(PRTypeFace.tfWithFont(this,
				PRTypeFace.PRFontHelveticaNeueLight));

		((TextView) findViewById(R.id.textView1)).setTypeface(PRTypeFace
				.tfWithFont(this, PRTypeFace.PRFontHelveticaNeueLight));
		
		countDownTV = (TextView) findViewById(R.id.countDownTextView);
		countDownTV.setTypeface(PRTypeFace.tfWithFont(this,
				PRTypeFace.PRFontHelveticaNeueLight));

		Date nowDate = new Date();
		String weddingDateString = "2013-12-07";
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date weddingDate = null;
		try {
			weddingDate = format.parse(weddingDateString);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		long diffInMs = weddingDate.getTime() - nowDate.getTime();
		long diffInSec = TimeUnit.MILLISECONDS.toSeconds(diffInMs);

		new CountDownTimer(diffInSec * 1000, 1000) {

			@Override
			public void onTick(long millisUntilFinished) {

				long seconds = (millisUntilFinished / 1000) % 60;
				long minutes = ((millisUntilFinished / (1000 * 60)) % 60);
				long hours = ((millisUntilFinished / (1000 * 60 * 60)) % 24);
				long days = ((millisUntilFinished / (1000 * 60 * 60 * 24)) % 365);
				// countDownTV.setText(String.format(
				// "%d Days %d Hours %d Mins %d Sec", days, hours,
				// minutes, seconds));
			}

			@Override
			public void onFinish() {
			}
		}.start();
	}

	@Override
	public void onBackPressed() {
	}

	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
		localyticsSession.open();
	}

	@Override
	protected void onPause() {
		// TODO Auto-generated method stub
		super.onPause();
		localyticsSession.close();
		localyticsSession.upload();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public void onClick(View v) {
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
