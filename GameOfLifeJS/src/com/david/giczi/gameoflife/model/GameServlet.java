package com.david.giczi.gameoflife.model;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/GameServlet")
public class GameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private TableLogic logic;
	private String patternName;
	
    public GameServlet() {
       
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String patternName=request.getParameter("pattern");
		String value=request.getParameter("input");
		String counter=request.getParameter("counter");
		String  store=request.getParameter("table");
		
		if(patternName!=null) {
			
			startFunction(patternName, request, response);
			
		}	
		else if(value!=null) {
			
			
			inputFunction(value, counter, store, request, response);
			
		}
		 
	}

	
	
	private void startFunction(String patternName, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if("Empty table".equals(patternName)) {
			this.patternName="Your pattern";
		}
		else {
			
			this.patternName=patternName;
		}
		
		logic=new TableLogic(Row.getRowValue());
		logic.inputPattern(patternName);
		
		request.setAttribute("counter", 0);
		request.setAttribute("badvalue", false);
		initJSP(request, response);
		
	}

	
	private void inputFunction(String input, String counter, String table, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
				if(logic==null) {
					
					startFunction("Empty table", request, response);
				}
		
			
			try {
				
				logic.editPatternInTable(input, table);
				
				request.setAttribute("badvalue", false);
				request.setAttribute("counter", counter);
				initJSP(request, response);
				
			} catch (InvalidInputValueException e) {
				
				logic.parseStringArrayToBooleanList(logic.convertStringToArray(table));
				request.setAttribute("badvalue", true);
				request.setAttribute("counter", counter);
				initJSP(request, response);
				
			}
				
			
	}
	
	
	
	private void initJSP(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		request.setAttribute("row", Row.getRowValue());
		request.setAttribute("names", PatternName.NAMES);
		request.setAttribute("pattern", logic.getPattern());
		request.setAttribute("patternName", patternName);
		request.getRequestDispatcher("table.jsp").forward(request, response);
			
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
	

}
