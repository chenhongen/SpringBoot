package com.che.bean;

import java.util.List;

public class City {
	private Long id;
    private String name;
    private List<Area> areas;

	public City() { }

    public City(Long id, String name, List<Area> areas) {
		super();
		this.id = id;
		this.name = name;
		this.areas = areas;
	}

	public Long getId() {
        return id;
    }
    
	public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public List<Area> getAreas() {
		return areas;
	}

	public void setAreas(List<Area> areas) {
		this.areas = areas;
	}

	@Override
    public String toString() {
        return "City {" + "id=" + id + ", name=" + name + '}';
    }
}
