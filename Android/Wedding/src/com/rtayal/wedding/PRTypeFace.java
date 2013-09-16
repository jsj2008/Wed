package com.rtayal.wedding;

import android.content.Context;
import android.graphics.Typeface;

public class PRTypeFace {
	
	public static String PRFontHelveticaNeueMedium = "HelveticaNeueMedium.ttf";
	public static String PRFontHelveticaNeueLight = "HelveticaNeueLight.ttf";
	
	public static Typeface tfWithFont(Context context, String fontName) {
		Typeface tf = Typeface.createFromAsset(context.getAssets(), "fonts/"
				+ fontName);
		return tf;
	}
}
