package com.xuyan.crud.test;

import java.util.Random;

public class GenarateName {
	

	public static StringBuffer getName() {
		
		Random random = new Random();
		StringBuffer name = new StringBuffer();
		
		switch(random.nextInt(5) + 3){
			case 3 : {
				name.append((char)(random.nextInt(26) + 65));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				break;
			}
			case 4 : {
				name.append((char)(random.nextInt(26) + 65));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				break;
			}
			case 5 : {
				name.append((char)(random.nextInt(26) + 65));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				break;
			}
			case 6 : {
				name.append((char)(random.nextInt(26) + 65));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				
				break;
			}
			case 7 : {
				name.append((char)(random.nextInt(26) + 65));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				name.append((char)(random.nextInt(26) + 97));
				break;
			}
			default : {
				System.out.println("Error!");
				break;
			}
		}
		return name;
	}
	
	
}
