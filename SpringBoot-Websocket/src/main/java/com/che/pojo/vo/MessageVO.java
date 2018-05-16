package com.che.pojo.vo;

public class MessageVO {
	private String vinCode;
	private String mac;

    public MessageVO() {
    }

    public MessageVO(String vinCode) {
        this.vinCode = vinCode;
    }

    public String getVinCode() {
        return vinCode;
    }

    public void setVinCode(String vinCode) {
        this.vinCode = vinCode;
    }

	public String getMac() {
		return mac;
	}

	public void setMac(String mac) {
		this.mac = mac;
	}
}
