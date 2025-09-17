package www.com.util;


import org.springframework.beans.factory.FactoryBean;
import java.nio.file.*;
import java.nio.charset.StandardCharsets;

public class SecretFileStringFactoryBean implements FactoryBean<String> {
  private String path;
  public void setPath(String path) { this.path = path; }

  @Override
  public String getObject() throws Exception {
    if (path == null) throw new IllegalStateException("Secret path is null");
    Path p = Paths.get(path);
    String s = new String(Files.readAllBytes(p), StandardCharsets.UTF_8).trim();
    if (s.isEmpty()) throw new IllegalStateException("Secret file is empty: " + path);
    return s;
  }

  @Override
  public Class<?> getObjectType() { return String.class; }

  @Override
  public boolean isSingleton() { return true; }  // ✅ 추가
}