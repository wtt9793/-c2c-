package com.wtt.pojo;

public class Notice {
    private Integer id;
    private String createAt;

    private Byte status;

    private String context;
    
    private User user;

//    private Integer user_id;

//    public Integer getUser_id(){
//    	return user_id;
//	}
//
//	public void setUser_id(Integer user_id){
//    	this.user_id=user_id;
//	}

	public Integer getId() {
    	return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCreateAt() {
		return createAt;
	}

	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}

	public Byte getStatus() {
		return status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
    
    

	
}