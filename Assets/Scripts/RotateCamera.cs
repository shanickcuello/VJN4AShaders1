using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class RotateCamera : MonoBehaviour
{
	public GameObject trf;
	public Slider slider;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {

    }

    public void OnChangeValue()
    {
        Quaternion quat = new Quaternion();
        quat.eulerAngles = new Vector3(0, slider.value, 0);

        trf.transform.rotation = quat;

        //trf.transform.rotation.Set(quat.eulerAngles.Set(0, slider.value, 0));
        //trf.transform.Rotate(new Vector3(0, slider.value, 0));
    }
}
