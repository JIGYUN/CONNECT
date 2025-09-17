package www.com.util;


import java.io.*;
import java.util.Vector;

import com.jcraft.jsch.*;


/**
 * jsch-X.X.XX.jar를 필요로 합니다. 
 * 없으면 jsch 검색
 */
public class SftpUtil 
{		
	private Session session = null;
	private Channel channel = null;
	private ChannelSftp channelSftp = null;
	
	public SftpUtil() {
	}
	    
	/**
	 * 서버와 연결에 필요한 값들을 가져와 초기화 시킴
	 * @param host  서버 주소
	 * @param userId  접속아이디
	 * @param password 비밀번호
	 * @param port 포트번호
	 */
	public void init(String host, String userId, String password, int port) {
		JSch jsch = new JSch();
		try {
			session = jsch.getSession(userId, host, port);
			session.setPassword(password);
			
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			
			session.setConfig(config);
			session.connect();
			
			channel = session.openChannel("sftp");
			channel.connect();
		} catch (JSchException e) {
		    e.printStackTrace();
		}
		
		channelSftp = (ChannelSftp) channel;
	}
	
	/**
	 * 하나의 파일을 업로드 한다.
	 * @param dir 저장시킬 주소(서버)
	 * @param file 저장할 파일경로
	 */
	public void put(String dir, String source) {
		
		FileInputStream in = null;
		try {
			File file = new File(source);
		    in = new FileInputStream(file);
		    channelSftp.cd(dir);
		    channelSftp.put(in, file.getName());
		} catch (SftpException e) {
		    e.printStackTrace();
		} catch (FileNotFoundException e) {
		    e.printStackTrace();
		} finally {
		    try {
		        in.close();
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
		}
	}
	/**
	 * 하나의 파일을 업로드 한다.
	 * @param dir 저장시킬 주소(서버)
	 * @param file 저장할 파일
	 */
	public void put(String dir, File file) {
		
		FileInputStream in = null;
		try {
		    in = new FileInputStream(file);
		    channelSftp.cd(dir);
		    channelSftp.put(in, file.getName());
		} catch (SftpException e) {
		    e.printStackTrace();
		} catch (FileNotFoundException e) {
		    e.printStackTrace();
		} finally {
		    try {
		        in.close();
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
		}
	}
	    
	/**
	 * 폴더를 생성한다.
	 * @param dir 생성할 폴더경로
	 */
	public void rmdir(String dir) {
		try {
		    channelSftp.mkdir(dir);
		} catch (SftpException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 파일을 다운로드 한다.
	 * @param dir 저장할 경로(서버)
	 * @param downloadFileName  다운로드할 파일
	 * @param path  저장될 공간
	 */
	public void get(String dir, String fileName, String targetPath) {
		FileOutputStream out = null;
		try {
			out = new FileOutputStream(new File(targetPath));
			channelSftp.cd(dir);
			channelSftp.get(fileName, out);
		} catch (SftpException e) {
			// TODO Auto-generated catch block
			System.out.println("원본 파일 ="+dir+"/"+fileName+ "을 "+targetPath+"로 가져오는중에 오류가 발생했습니다.");
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("원본 파일 ="+dir+"/"+fileName+ "을 "+targetPath+"로 가져오는중에 오류가 발생했습니다.");
		    e.printStackTrace();
		} finally {
		    try {
		        out.close();
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
		}
	}

	public void setEncoding(String encoding) {
		try {
			channelSftp.setFilenameEncoding(encoding);
		} catch (SftpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 파일을 다운로드 한다.
	 * @param sourcePath 저장할 경로와 파일명까지(서버)
	 * @param targetPath 저장될 공간만
	 */
	public void get(String sourcePath, String targetPath) {
		FileOutputStream out = null;
		try {
			int index = sourcePath.lastIndexOf(File.separator);
			if (index < 0) {
				index = sourcePath.lastIndexOf("/");
			}
			sourcePath = sourcePath.substring(0, index);
			String fileName = sourcePath.substring(index+1, sourcePath.length());
			out = new FileOutputStream(new File(targetPath+ File.separator +fileName));
			channelSftp.cd(sourcePath);
			channelSftp.get(fileName, out);
			
		} catch (SftpException e) {
			System.out.println("원본 파일 ="+sourcePath+ "을 "+targetPath+"로 가져오는중에 오류가 발생했습니다.");
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println("원본 파일 ="+sourcePath+ "을 "+targetPath+"로 가져오는중에 오류가 발생했습니다.");
			
			// TODO Auto-generated catch block
		    e.printStackTrace();
		} finally {
		    try {
		        out.close();
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
		}
	}
	
	/**
	 * 파일을 다운로드 한다.
	 * @param dir 저장할 경로(서버)
	 * @param downloadFileName  다운로드할 파일
	 * @param path  저장될 공간
	 */
	
	public Vector ls(String dir) {
		Vector vector = null;
		try {
			
			vector = channelSftp.ls(dir);
		} catch (SftpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return vector;
	}
	
	/**
	 * 서버와의 연결을 끊는다.
	 */
	public void disconnection() {
		channelSftp.quit();
	}
	
}
