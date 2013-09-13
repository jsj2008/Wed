package com.rtayal.wedding.gallery;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import org.apache.http.HttpEntity;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicHttpResponse;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.widget.Toast;

import com.rtayal.wedding.Constants;

@SuppressLint("DefaultLocale")
public class GalleryServiceCaller {

	Context mContext;

	public GalleryServiceCaller(Context mContext) {
		// TODO Auto-generated constructor stub
		this.mContext = mContext;
	}

	private boolean isOnline() {
		boolean status = false;
		try {
			ConnectivityManager cm = (ConnectivityManager) mContext
					.getSystemService(Context.CONNECTIVITY_SERVICE);
			NetworkInfo netInfo = cm.getNetworkInfo(0);
			if (netInfo != null
					&& netInfo.getState() == NetworkInfo.State.CONNECTED) {
				status = true;
			} else {
				netInfo = cm.getNetworkInfo(1);
				if (netInfo != null
						&& netInfo.getState() == NetworkInfo.State.CONNECTED) {
					status = true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return status;
	}

	public String registerAccount() {
		return "";
	}

	public String newLogin(String username, String password) {
		if (isOnline()) {

			// String envelope = String
			// .format("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
			// +
			// "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
			// + "<soap:Body>\n"
			// + " <WM_Login_MobileApp xmlns=\"Ideosity.MobileAppService\">\n"
			// + "<username>%s</username>\n"
			// + "<password>%s</password>\n"
			// + "</WM_Login_MobileApp>\n" + "</soap:Body>\n"
			// + "</soap:Envelope>", username, password);

			JSONObject parameters = new JSONObject();
			try {
				parameters.put("command", "register");
				parameters.put("password", "password");
				parameters.put("username", "Rishabhs iPhone");

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			String response = makeWebServiceCall(Constants.kAPIHost
					+ Constants.kAPIPath, parameters.toString());
			return response;
		} else {
			showNoInternetToast();

			return "";
		}
	}

	private String makeWebServiceCall(String url, String envelope) {
		HttpPost httpPost = new HttpPost(url);

		StringEntity se = null;
		HttpClient httpClient = new DefaultHttpClient();
		BasicHttpResponse httpResponse = null;
		if (envelope != null) {
			try {
				se = new StringEntity(envelope, HTTP.UTF_8);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			se.setContentType("application/json");
			httpPost.setHeader("Content-Type",
					"application/json; charset=utf-8");
			httpPost.setEntity(se);
		}

		try {
			httpResponse = (BasicHttpResponse) httpClient.execute(httpPost);
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		HttpEntity responseEntity = httpResponse.getEntity();

		try {
			return EntityUtils.toString(responseEntity, HTTP.UTF_8);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	// private void storeDataLocally(String fileName, String data) {
	// // Only store data if the String doesn not contains Token Expired
	// // response from webservice.
	// if (!data.contains(Constants.Web_Service_Response_Token_Expired)) {
	// File file = new File(mContext.getExternalFilesDir("Data Files"),
	// fileName);
	//
	// try {
	// FileOutputStream f = new FileOutputStream(file);
	// PrintWriter pw = new PrintWriter(f);
	// pw.println(data);
	// Log.i("Service Caller", "Data Written Successfully");
	// pw.flush();
	// pw.close();
	// f.close();
	// } catch (FileNotFoundException e) {
	// e.printStackTrace();
	// Log.i("", "******* File not found. Did you");
	// } catch (IOException e) {
	// e.printStackTrace();
	// }
	// }
	// }
	//
	// private String readDataLocally(String fileName) {
	//
	// StringBuilder sb = null;
	// try {
	// File file = new File(mContext.getExternalFilesDir("Data Files"),
	// fileName);
	//
	// Reader reader = new FileReader(file);
	// sb = new StringBuilder();
	// char buff[] = new char[16384];
	// int len;
	// while ((len = reader.read(buff)) > 0) {
	// sb.append(buff, 0, len);
	// }
	// reader.close();
	// } catch (IOException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	// if (sb == null) {
	// return "";
	// }
	// return sb.toString();
	// }

	private void showNoInternetToast() {
		((Activity) mContext).runOnUiThread(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				Toast.makeText(
						mContext,
						"Network Not Reachable. Please connect to an active Internet connection.",
						Toast.LENGTH_SHORT).show();
			}
		});
	}
}