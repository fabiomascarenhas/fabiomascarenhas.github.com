package gossip;

import java.util.List;

public class StringUtils {
	public static <T> String join(List<T> args, String sep) {
		StringBuilder sb = new StringBuilder();
		boolean first = true;
		for(T arg : args) {
			if(first) {
				first = false;
				sb.append(arg);
			} else {
				sb.append(sep);
				sb.append(arg);
			}
		}
		return sb.toString();
	}
}
