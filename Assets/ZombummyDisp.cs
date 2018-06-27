using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ZombummyDisp : MonoBehaviour {
	public float RotSpeed = 1;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		float rotY = Time.deltaTime * RotSpeed;
		transform.localEulerAngles += new Vector3 (0, rotY,0);
	}
}
