package www.com.util;

/*
 * Copyright 2001-2006 The Apache Software Foundation.
 *
 * Licensed under the Apache License, Version 2.0 (the ";License&quot;);
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS"; BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Locale;
import java.util.Set;

public class RadioUtil {
    
    /**
     * 문자열이 지정한 길이를 초과했을때 지정한길이에다가 해당 문자열을 붙여주는 메서드.
     *  ex> "가나다라마바사"  ＞  "가나다..."
     *  
     * @param source 원본 문자열 배열
     * @param output 더할문자열
     * @param slength 지정길이
     * @return 지정길이로 잘라서 더할분자열 합친 문자열
     */
    public static String print(HashMap hmap, String id, String value, String script) {
        StringBuffer sb = new StringBuffer();
        String key = "";
        String str = "";
        
        Iterator iter = hmap.keySet().iterator();
		while(iter.hasNext()) {
			key = (String)iter.next();
			str = (String)hmap.get(key);
			sb.append("<input type=\"radio\" name=\""+id+"\" id=\""+id+"\"  value=\""+key+"\" "+StringUtil.compareSelected(key, value)+"  "+script+" />"+str+"");
		}
        
        return sb.toString();
    }
    
    /**
     * 문자열이 지정한 길이를 초과했을때 지정한길이에다가 해당 문자열을 붙여주는 메서드.
     *  ex> "가나다라마바사"  ＞  "가나다..."
     *  
     * @param source 원본 문자열 배열
     * @param output 더할문자열
     * @param slength 지정길이
     * @return 지정길이로 잘라서 더할분자열 합친 문자열
     */
    public static String print(Hashtable htable, String id, String value, String script) {
        StringBuffer sb = new StringBuffer();
        String key = "";
        String str = "";
        
        Set set = htable.keySet(); 
        Object []hmKeys = set.toArray(); 
        for(int i = (hmKeys.length-1); i >= 0; i--)  {
            key = (String)hmKeys[i];
            str = (String)htable.get(key);
            if (i < (hmKeys.length-1)) {
            	sb.append("&nbsp;&nbsp;");
            }
            sb.append("<input type=\"radio\" name=\""+id+"\" id=\""+id+"\"  value=\""+key+"\" "+StringUtil.compareChecked(key, value)+"  "+script+" />"+str+"");
        }
        return sb.toString();
    }
    
    public static String useYn(String id, String value, String script) {

    	Hashtable hmap = new Hashtable();
        hmap.put("Y", "사용");
        hmap.put("N", "사용안함");
        return print(hmap, id, value, script);
    }
    
}
