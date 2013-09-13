package com.rtayal.wedding.family;

import java.util.ArrayList;
import java.util.HashMap;

import com.rtayal.wedding.R;

import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.BaseAdapter;
import android.widget.TextView;

public class FamilyListAdapter extends BaseAdapter {

	private int selectedIdx;
	private int selectedColor = Color.parseColor("#0099CC");;

	private final class ViewHolder {
		View v;
		// TextView addressTextView;
	}

	Context mContext;
	private ViewHolder mHolder = null;
	private ArrayList<HashMap<String, Object>> familyListArray = new ArrayList<HashMap<String, Object>>();

	public FamilyListAdapter(Context context,
			ArrayList<HashMap<String, Object>> familyListArray) {
		mContext = context;
		this.familyListArray = familyListArray;
		selectedIdx = -1;
	}

	public void selectedIndex(int ind) {
		selectedIdx = ind;
		notifyDataSetChanged();
	}

	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		return familyListArray.size();
	}

	@Override
	public Object getItem(int arg0) {
		// TODO Auto-generated method stub
		return arg0;
	}

	@Override
	public long getItemId(int arg0) {
		// TODO Auto-generated method stub
		return arg0;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		// TODO Auto-generated method stub
		if (convertView == null) {
			mHolder = new ViewHolder();
			convertView = ((LayoutInflater) mContext
					.getSystemService(Context.LAYOUT_INFLATER_SERVICE))
					.inflate(R.layout.family_list_item, null);
			mHolder.v = convertView;
			convertView.setTag(mHolder);
		} else {
			mHolder = (ViewHolder) convertView.getTag();
		}

		if (position != -1 && position == selectedIdx) {
			mHolder.v.setBackgroundColor(selectedColor);
		} else {
			mHolder.v.setBackgroundColor(Color.TRANSPARENT);
		}

		TextView familyMemberTV = (TextView) convertView
				.findViewById(R.id.familyMemberName);
		familyMemberTV.setText((CharSequence) familyListArray.get(position)
				.get("Name"));

		TextView relationTV = ((TextView) convertView
				.findViewById(R.id.relationTextView));

		relationTV.setText((CharSequence) familyListArray.get(position).get(
				"Relation"));

		Animation slideLeftAnimation = AnimationUtils.loadAnimation(mContext,
				R.anim.slide_left);

		Animation slideRightAnimation = AnimationUtils.loadAnimation(mContext,
				R.anim.slide_right);

		familyMemberTV.startAnimation(slideLeftAnimation);
		relationTV.startAnimation(slideRightAnimation);
		return convertView;
	}
}
