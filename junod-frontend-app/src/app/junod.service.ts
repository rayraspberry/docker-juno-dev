import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, map } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class JunodService {
  private junod_app_url = 'http://localhost:8081/';
  constructor(private http: HttpClient) {}

  getJunodBase(): Observable<JunodResult> {
    return this.http.get<JunodResult>(this.junod_app_url);
  }
}

export class JunodResult {
  message!: string;
  result!: string;
}
