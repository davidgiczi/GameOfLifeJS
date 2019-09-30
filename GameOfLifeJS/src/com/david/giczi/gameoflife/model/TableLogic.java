package com.david.giczi.gameoflife.model;

import java.util.ArrayList;
import java.util.List;

public class TableLogic implements Pattern, PatternName{

	
	private List<Boolean> pattern;
	private int row;
	
	public TableLogic(int rowNumber) {
		
		row=rowNumber;
		pattern=new ArrayList<>();
		
		for(int i=0; i<row*row; i++) {
			pattern.add(false);
		}
			
	}

	
	public List<Boolean> getPattern() {
		return pattern;
	}


	public void inputPattern(String name) {
		
		
		for(int i=0; i<NAMES.length; i++) {
			
			
			if(NAMES[i].equals(name)) {
				
				
				for (Integer  value : transformPatternForDifferentTableSize(PATTERNS[i])) {
					
					pattern.set(value, true);
				}
					
			}
				
		}
			
	}
	
	
	public void editPatternInTable(String value, String table) throws InvalidInputValueException {
		
		String[] store=convertStringToArray(table);
		
		try {
			
			int  index=Integer.parseInt(value);

			if(index<=row || index>=row*row) {
				
				throw new InvalidInputValueException();
			}
			
			for(int i=0; i<row*row; i+=row) {
				
				if(index==i) {
					throw new InvalidInputValueException();
				}
				
			}
			
			if("true".equals(store[index])) {
				
				store[index]="false";
				
			}
			else if("false".equals(store[index])) {
				
				store[index]="true";
				
			}
			
			
			parseStringArrayToBooleanList(store);
			
			
			
		} catch (NumberFormatException e) {
			
			throw new InvalidInputValueException();
		}
		
		
		
	}
	
	public void parseStringArrayToBooleanList(String[] table) {
		
		pattern.clear();
		
		for (String string : table) {
			
			pattern.add(Boolean.parseBoolean(string));
			
		}
		
	}
	
	public String[] convertStringToArray(String store) {
		return store.split(",");
	}
	
	private Integer[] transformPatternForDifferentTableSize(Integer[] pattern) {
		
		Integer[] convertPattern=new Integer[pattern.length];
		
		for (int i=0; i<pattern.length; i++) {
			
			int x=pattern[i]/50;
			int y=pattern[i]%50;
			
			convertPattern[i]=x*row+y;
			
		}
		
		return convertPattern;
	}
	
}
