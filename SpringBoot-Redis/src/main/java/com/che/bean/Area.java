package com.che.bean;

public class Area {
	private Long id;
	private Long cityId;
    private String name;

	public Area() { }
	
    public Area(Long id, Long cityId, String name) {
		super();
		this.id = id;
		this.cityId = cityId;
		this.name = name;
	}

	public Long getId() {
        return id;
    }
    
	public void setId(Long id) {
        this.id = id;
    }

    public Long getCityId() {
		return cityId;
	}

	public void setCityId(Long cityId) {
		this.cityId = cityId;
	}

	public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Area {" + "id=" + id + ", cityId=" + cityId + ", name=" + name + '}';
    }
}
