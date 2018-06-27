using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//[ExecuteInEditMode]
public class DecalOnOff : MonoBehaviour {

	public bool showDecal = false;
	public Material mat;

	// Use this for initialization
	void Start () {
		mat = GetComponent<Renderer> ().material;
		//mat = GetComponent<Material> ();
	}

	void OnMouseDown(){
		showDecal = !showDecal;
		if (showDecal) {
			mat.SetFloat ("_ShowDecal", 1);
		} else {
			mat.SetFloat ("_ShowDecal", 0);
		}
	}

	// Update is called once per frame
	void Update () {
		
	}
}
