using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    [SerializeField]
    private GameObject[] addons;
    private GameObject[] _diapos;
    private int _currentDiapo;

    private void Awake()
    {
        _currentDiapo = 0;
        _diapos = new GameObject[transform.childCount];
        
        for (int i = 0; i < transform.childCount; i++)
        {
            _diapos[i] = transform.GetChild(i).gameObject;
        }
        
        ChangeDiapo(0);
    }

    private void Update()
    {
        if (Input.GetKeyUp(KeyCode.RightArrow) && _currentDiapo != transform.childCount-1)
        {
            ChangeDiapo(_currentDiapo + 1);
            _currentDiapo++;
        }
        
        else if (Input.GetKeyUp(KeyCode.LeftArrow) && _currentDiapo != 0)
        {
            ChangeDiapo(_currentDiapo - 1);
            _currentDiapo--;
        }
    }

    void ChangeDiapo(int c)
    {
        for (int i = 0; i < addons.Length; i++)
        {
            addons[i].SetActive(false);
        }
        for (int i = 0; i < transform.childCount; i++)
        {
            _diapos[i].SetActive(false);
        }
        _diapos[c].SetActive(true);
    }
}
