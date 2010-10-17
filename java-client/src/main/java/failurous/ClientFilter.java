package failurous;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.MalformedURLException;
import java.util.Collections;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class ClientFilter implements Filter {
	
	private String endpointUrl;
	private HttpClient httpClient = new HttpClient(new MultiThreadedHttpConnectionManager());
	
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		try {
			chain.doFilter(req, res);
		} catch (IOException e) {
			System.out.println("caught");
			sendReport(e, req);
			throw e;
		} catch (ServletException e) {
			System.out.println("caught");
			sendReport(e, req);
			throw e;			
		} catch (RuntimeException e) {
			System.out.println("caught");
			sendReport(e, req);
			throw e;
		}
	}
	
	private void sendReport(Throwable t, ServletRequest request) {
		OutputStream out = null;
		try {
			PostMethod post = new PostMethod(endpointUrl);
			NameValuePair pair = new NameValuePair("data", constructReport(t, (HttpServletRequest)request));
			post.setRequestBody(new NameValuePair[] { pair });
			try {
				httpClient.executeMethod(post);
				System.out.println("sent");
			} finally {
				post.releaseConnection();
			}
		} catch (MalformedURLException e) {
			throw new FailurousException(e);
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException ioe) {
				}
			}
		}
	}

	private String constructReport(Throwable t, HttpServletRequest request) {
		try {
			JSONObject report = new JSONObject();
			report.put("title", t.getMessage());
			
			JSONArray data = new JSONArray();
			data.put(getSummary(t, request));
			data.put(getDetails(t));
			data.put(getRequestInfo(request));
			data.put(getSessionInfo(request));
			report.put("data", data);
			
			return report.toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}

	private JSONArray getSummary(Throwable t, HttpServletRequest request) throws JSONException {
		JSONArray summary = new JSONArray();
		summary.put("summary");
		JSONArray summaryContent = new JSONArray();
		summaryContent.put(constructField("type", t.getClass().getCanonicalName(), "use_in_checksum", "true"));
		summaryContent.put(constructField("message", t.getMessage()));
		summaryContent.put(constructField("location", t.getStackTrace()[0].toString(), "use_in_checksum", "true"));
		summaryContent.put(constructField("request_url", request.getRequestURL().toString()));
		summary.put(summaryContent);
		return summary;
	}

	private JSONArray getDetails(Throwable t) throws JSONException {
		JSONArray details = new JSONArray();
		details.put("details");
		JSONArray detailsContent = new JSONArray();
		detailsContent.put(constructField("stacktrace", getStackTraceString(t)));
		details.put(detailsContent);
		return details;
	}

	@SuppressWarnings("unchecked")
	private JSONArray getRequestInfo(HttpServletRequest request) throws JSONException {
		JSONArray requestInfo = new JSONArray();
		requestInfo.put("Request");
		JSONArray requestInfoContent = new JSONArray();
		requestInfoContent.put(constructField("url", request.getRequestURL().toString()));
		requestInfoContent.put(constructField("remote_address", request.getRemoteAddr()));
		List<String> headers = Collections.list(request.getHeaderNames());
		for (String header : headers) {
			requestInfoContent.put(constructField(header, request.getHeader(header)));	
		}
		requestInfo.put(requestInfoContent);
		return requestInfo;
	}
	
	@SuppressWarnings("unchecked")
	private JSONArray getSessionInfo(HttpServletRequest request) throws JSONException {
		JSONArray session = new JSONArray();
		session.put("Session");
		JSONArray sessionContent = new JSONArray();
		if (request.getSession(false) != null) {
			List<String> keys = Collections.list(request.getSession().getAttributeNames());
			for (String key : keys) {
				Object value = request.getSession().getAttribute(key);
				sessionContent.put(constructField(key, value.toString()));
			}
		}
		session.put(sessionContent);
		return session;
	}	

	private JSONArray constructField(String name, String value, String... options) throws JSONException {
		JSONArray type = new JSONArray();
		type.put(name);
		type.put(value);
		JSONObject opts = new JSONObject();
		for (int i=0 ; i<options.length ; i += 2) {
			opts.put(options[i], options[i+1]);
		}
		type.put(opts);
		
		return type;
	}
	
	private String getStackTraceString(Throwable t) {
		StringWriter res = new StringWriter();
		t.printStackTrace(new PrintWriter(res));
		res.flush();
		return res.toString();
	}

	public void init(FilterConfig cfg) throws ServletException {
		String serverAddress = cfg.getInitParameter("serverAddress");
		String apiKey = cfg.getInitParameter("apiKey");
		
		if (!serverAddress.startsWith("http")) {
			serverAddress = "http://" + serverAddress;
		}
		if (!serverAddress.endsWith("/")) {
			serverAddress += "/";
		}
		
		this.endpointUrl = serverAddress + "api/projects/" + apiKey + "/fails";
	}
	
	public void destroy() {		
	}
	
}
